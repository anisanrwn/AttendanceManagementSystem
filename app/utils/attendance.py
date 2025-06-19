from datetime import datetime, date, time,  timedelta
from sqlalchemy.orm import Session
from app.models import model as m
import pytz
from app.utils.time import get_ntp_time

wib = pytz.timezone("Asia/Jakarta")

def format_time(dt: datetime | None):
    if not dt:
        return None
    return dt.strftime('%H:%M:%S')

def calculate_total_working(clock_in: time, clock_out: time, attendance_date: date):
    if not clock_in or not clock_out:
        return None
    in_dt = datetime.combine(attendance_date, clock_in)
    out_dt = datetime.combine(attendance_date, clock_out)
    duration = out_dt - in_dt
    return int(duration.total_seconds())

def calculate_late(clock_in: time, office_start: time, attendance_date: date) -> int:
    in_dt = datetime.combine(attendance_date, clock_in)
    office_start_dt = datetime.combine(attendance_date, office_start)
    late_seconds = max(0, (in_dt - office_start_dt).total_seconds())
    return int(late_seconds)

def calculate_overtime(clock_out: time, office_end: time, attendance_date: date) -> int:
    out_dt = datetime.combine(attendance_date, clock_out)
    office_end_dt = datetime.combine(attendance_date, office_end)
    overtime_seconds = max(0, (out_dt - office_end_dt).total_seconds())
    return int(overtime_seconds)

def mark_absent_for_missing_days(db: Session, employee_id: int):
    today = get_ntp_time().date()
    
    last_attendance = (
        db.query(m.Attendance)
        .filter(m.Attendance.employee_id == employee_id)
        .order_by(m.Attendance.attendance_date.desc())
        .first()
    )
    
    last_date = last_attendance.attendance_date if last_attendance else today - timedelta(days=1)
    
    current_date = last_date + timedelta(days=1)
    while current_date < today:
        if current_date.weekday() >= 5:
            current_date += timedelta(days=1)
            continue
        
        permission_exist = (
            db.query(m.Permission)
            .filter(
                m.Permission.employee_id == employee_id,
                m.Permission.permission_status == "Approved",
                m.Permission.start_date <= current_date,
                m.Permission.end_date >= current_date
            )
            .first()
        )
        
        attendance_exist = (
            db.query(m.Attendance)
            .filter(
                m.Attendance.employee_id == employee_id,
                m.Attendance.attendance_date == current_date
            )
            .first()
        )
        
        if not attendance_exist:
            attendance_status = "Permit" if permission_exist else "Absent"
            new_attendance = m.Attendance(
                employee_id=employee_id,
                attendance_date=current_date,
                attendance_status=attendance_status,
                clock_in=None,
                clock_out=None,
                clock_in_verified=False,
                clock_out_verified=False,
                face_verified=False
            )
            db.add(new_attendance)
        
        current_date += timedelta(days=1)
    
    db.commit()
