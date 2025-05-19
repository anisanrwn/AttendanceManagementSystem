from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.face_recog import verify_face
import json
from datetime import datetime, timedelta, timezone, date

router = APIRouter(prefix="/attendance", tags=["Attendance"])

@router.get("/server-time")
def get_server_time():
    wib = timezone(timedelta(hours=7))  # GMT+7
    now_wib = datetime.now(wib)
    return {"serverTime": now_wib.isoformat()}


@router.post("/clockin", response_model=s.AttendanceOut)
def clock_in_attendance(payload: s.AttendanceClockInSession, db: Session = Depends(get_db)):
    employee_id = int(payload.dict().get("employee_id"))  # From session in JS

    # Ambil data employee
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")

    if not employee.face_encoding:
        raise HTTPException(status_code=400, detail="Employee has no face encoding")

    # Verifikasi wajah
    known_encoding = json.loads(employee.face_encoding)  # encoding dari DB
    is_verified = verify_face(payload.image_base64, known_encoding)

    # Cek sudah absen hari ini atau belum
    today = date.today()
    existing_attendance = db.query(m.Attendance).filter(
        m.Attendance.employee_id == employee_id,
        m.Attendance.attendance_date == today
    ).first()

    if existing_attendance:
        raise HTTPException(status_code=400, detail="Already clocked in today")

    # Buat record attendance
    attendance = m.Attendance(
        employee_id=employee_id,
        clock_in=datetime.now().time(),
        clock_in_latitude=payload.clock_in_latitude,
        clock_in_longitude=payload.clock_in_longitude,
        clock_in_reason=payload.clock_in_reason,
        clock_in_verified=True,
        face_verified=is_verified,
        attendance_date=today,
        attendance_status="Present" if is_verified else "Unverified"
    )

    db.add(attendance)
    db.commit()
    db.refresh(attendance)

    return attendance