from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.face_recog import verify_face_multi
from app.utils.attendance import format_time, calculate_total_working,calculate_late, calculate_overtime
from app.utils.time import get_ntp_time
from app.utils.holiday import fetch_national_holidays 
import json
from datetime import datetime, date, time

router = APIRouter(prefix="/attendance", tags=["Attendance"])

OFFICE_START = time(8, 0, 0)
#MAX_PUNCH_IN = time(17, 0)
OFFICE_END = time(16, 45, 0)

@router.get("/server-time")
def get_server_time():
    return {"serverTime": get_ntp_time().isoformat()}

@router.get("/holidays")
def get_holidays():
    today_year = datetime.today().year
    holidays = fetch_national_holidays(today_year)
    return {"holidays": sorted(str(d) for d in holidays)}

    
@router.post("/clockin", response_model=s.AttendanceOut)
def clock_in_attendance(payload: s.AttendanceClockInSession, db: Session = Depends(get_db)):
    employee_id = int(payload.dict().get("employee_id"))
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")

    if not employee.face_encoding:
        raise HTTPException(status_code=400, detail="Employee has no face encoding")

    known_encoding = json.loads(employee.face_encoding)
    is_verified, distances = verify_face_multi(payload.image_base64, known_encoding)

    if not is_verified:
        raise HTTPException(
            status_code=400,
            detail="Face not recognized",
        )

    today = date.today()
    existing_attendance = db.query(m.Attendance).filter(
        m.Attendance.employee_id == employee_id,
        m.Attendance.attendance_date == today
    ).first()

    if existing_attendance:
        raise HTTPException(status_code=400, detail="Already clocked in today")
    
    now = get_ntp_time()

    #if now.time() > MAX_PUNCH_IN:
    #    raise HTTPException(status_code=400, detail="Clock-in time exceeded")

    attendance = m.Attendance(
        employee_id=employee_id,
        clock_in=now.time(),
        clock_in_latitude=payload.clock_in_latitude,
        clock_in_longitude=payload.clock_in_longitude,
        clock_in_reason=payload.clock_in_reason,
        clock_in_verified=True,
        clock_in_distance=min(distances) if distances else None,
        face_verified=is_verified,
        attendance_date=today,
        attendance_status="Punch In" if is_verified else "Absent",
        late = calculate_late(now.time(), OFFICE_START, now.date()),
    )

    db.add(attendance)
    db.commit()
    db.refresh(attendance)

    return attendance

@router.post("/clockout", response_model=s.AttendanceOut)
def clock_out_attendance(payload: s.AttendanceClockOutSession, db: Session = Depends(get_db)):
    employee_id = int(payload.employee_id)

    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")

    if not employee.face_encoding:
        raise HTTPException(status_code=400, detail="Employee has no face encoding")

    known_encoding = json.loads(employee.face_encoding)
    is_verified, distances = verify_face_multi(payload.image_base64, known_encoding)

    if not is_verified:
        raise HTTPException(
            status_code=400,
            detail="Face not recognized",
        )

    today = date.today()
    attendance = db.query(m.Attendance).filter(
        m.Attendance.employee_id == employee_id,
        m.Attendance.attendance_date == today
    ).first()

    if not attendance:
        raise HTTPException(status_code=400, detail="Clock in record not found for today")

    if attendance.clock_out is not None:
        raise HTTPException(status_code=400, detail="Already clocked out today")
    
    now = get_ntp_time()
    attendance.clock_out = now.time()
    attendance.clock_out_latitude = payload.clock_out_latitude
    attendance.clock_out_longitude = payload.clock_out_longitude
    attendance.clock_out_reason = payload.clock_out_reason
    attendance.clock_out_verified = True
    attendance.face_verified = attendance.face_verified and is_verified 
    attendance.attendance_status = "Punch Out" if is_verified else "Absent"
    attendance.clock_out_distance = min(distances) if distances else None
    attendance.working_hour = calculate_total_working(attendance.clock_in, attendance.clock_out, today)
    attendance.overtime = calculate_overtime(now.time(), OFFICE_END, now.date())

    db.commit()
    db.refresh(attendance)

    return attendance

@router.get('/attendance-status', response_model=s.AttendanceStatusResponse | None)
def get_attendance_status(employee_id: int, db: Session = Depends(get_db)):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail='Employee not found')

    today = date.today()
    attendance = (
        db.query(m.Attendance)
        .filter(
            m.Attendance.employee_id == employee.employee_id,
            m.Attendance.attendance_date == today
        )
        .first()
    )

    if not attendance:
        return {
            "attendance_id": None,
            "attendance_date": today,
            "employee_id": employee_id,
            "clock_in": None,
            "clock_out": None,
            "totalHours": None,
            "attendance_status": "Absent",
            "clock_in_latitude": None,
            "clock_in_longitude": None,
            "clock_in_verified": False,
            "face_verified": False,
        }

    return {
        "attendance_id": attendance.attendance_id,
        "attendance_date": attendance.attendance_date,
        "employee_id": employee_id,
        "clock_in": format_time(attendance.clock_in),
        "clock_out": format_time(attendance.clock_out),
        "totalHours": calculate_total_working(attendance.clock_in, attendance.clock_out, today),
        "attendance_status": attendance.attendance_status,
        "clock_in_latitude": attendance.clock_in_latitude,
        "clock_in_longitude": attendance.clock_in_longitude,
        "clock_in_verified": attendance.clock_in_verified,
        "face_verified": attendance.face_verified,
    }

@router.get("/recap")
def view_attendance(employee_id: int, db: Session = Depends(get_db)):
    records = (
        db.query(m.Attendance)
        .filter(m.Attendance.employee_id == employee_id)
        .order_by(m.Attendance.attendance_date.desc())
        .all()
    )
    current_year = date.today().year
    holidays = fetch_national_holidays(current_year)
    
    result = []
    for rec in records:
        result.append({
            "attendance_date": rec.attendance_date.isoformat(),
            "attendance_status": rec.attendance_status,
            "clock_in": rec.clock_in.strftime('%H:%M:%S') if rec.clock_in else None,
            "clock_out": rec.clock_out.strftime('%H:%M:%S') if rec.clock_out else None,
            "totalHours": calculate_total_working(rec.clock_in, rec.clock_out, rec.attendance_date),
            "late": calculate_late(rec.clock_in, OFFICE_START, rec.attendance_date) if rec.clock_in else None,
            "overtime": calculate_overtime(rec.clock_out, OFFICE_END, rec.attendance_date) if rec.clock_out else None,
        })
    return {
        "attendance": result,
        "holidays": [str(h) for h in holidays]}

@router.get("/recap/all")
def view_all_attendance(db: Session = Depends(get_db)):
    records = (
        db.query(m.Attendance)
        .join(m.Employee)
        .order_by(m.Attendance.attendance_date.desc())
        .all()
    )
    current_year = date.today().year
    holidays = fetch_national_holidays(current_year)

    result = []
    for rec in records:
        employee = rec.employee
        result.append({
            "attendance_id": rec.attendance_id,
            "attendance_date": rec.attendance_date.isoformat(),
            "attendance_status": rec.attendance_status,
            "employee_id": employee.employee_id,
            "employee_name": f"{employee.first_name} {employee.last_name}".strip(),
            "clock_in": rec.clock_in.strftime('%H:%M:%S') if rec.clock_in else None,
            "clock_out": rec.clock_out.strftime('%H:%M:%S') if rec.clock_out else None,
            "clock_in_lat": rec.clock_in_latitude,
            "clock_in_lng": rec.clock_in_longitude,
            "clock_out_lat": rec.clock_out_latitude,
            "clock_out_lng": rec.clock_out_longitude,
            "clock_in_reason": rec.clock_in_reason,
            "clock_out_reason": rec.clock_out_reason,
            "face_verified": rec.face_verified,
            "totalHours": calculate_total_working(rec.clock_in, rec.clock_out, rec.attendance_date),
            "late": calculate_late(rec.clock_in, OFFICE_START, rec.attendance_date) if rec.clock_in else None,
            "overtime": calculate_overtime(rec.clock_out, OFFICE_END, rec.attendance_date) if rec.clock_out else None,
        })

    return {
        "attendance": result,
        "holidays": [str(h) for h in holidays]}

@router.post("/verify")
def verify_route(payload: s.AttendanceVerifyIdentity, db: Session = Depends(get_db)):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == payload.employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")

    if not employee.face_encoding:
        raise HTTPException(status_code=400, detail="No face encoding for this employee")

    known_encodings = json.loads(employee.face_encoding)
    is_verified, distances = verify_face_multi(payload.image_base64, known_encodings)

    if distances is None:
        raise HTTPException(status_code=400, detail="No face detected")

    return {
        "is_verified": bool(is_verified),
        "distances": distances,
        "min_distance": float(min(distances)),
        "max_distance": float(max(distances)),
        "avg_distance": float(sum(distances) / len(distances))
    }
