from datetime import datetime, date, time,  timedelta
from sqlalchemy.orm import Session
from app.models import model as m
from app.utils.time import get_ntp_time
from app.utils.holiday import fetch_national_holidays 

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
    holidays = fetch_national_holidays(today.year)

    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if (
        not employee
        or not employee.join_date
        or not employee.user
        or all(role.roles_id != 3 for role in employee.user.roles) 
    ):
        return
    
    start_date = employee.join_date
    current_date = start_date

    while current_date < today:
        attendance_exist = db.query(m.Attendance).filter(
            m.Attendance.employee_id == employee_id,
            m.Attendance.attendance_date == current_date
        ).first()

        if attendance_exist:
            current_date += timedelta(days=1)
            continue

        if current_date.weekday() >= 5:
            status = "Weekend"
        elif current_date in holidays:
            status = "Holiday"
        else:
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
            status = "Permit" if permission_exist else "Absent"

        new_attendance = m.Attendance(
            employee_id=employee_id,
            attendance_date=current_date,
            attendance_status=status,
            clock_in=None,
            clock_out=None,
            clock_in_verified=False,
            clock_out_verified=False,
            face_verified=False
        )
        db.add(new_attendance)

        current_date += timedelta(days=1)

    db.commit()
