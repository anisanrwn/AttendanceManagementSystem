from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.face_recog import read_image, encode_face
import numpy as np
import base64
from datetime import datetime, timedelta, timezone, date
from fastapi import APIRouter, UploadFile, File, Form



router = APIRouter(prefix="/attendance", tags=["Attendance"])

@router.get("/server-time")
def get_server_time():
    wib = timezone(timedelta(hours=7))  # GMT+7
    now_wib = datetime.now(wib)
    return {"serverTime": now_wib.isoformat()}

@router.post("/clock_in")
async def clock_in_employee(
    file: UploadFile = File(...),
    latitude: float = Form(...),
    longitude: float = Form(...),
    db: Session = Depends(get_db)
):
    try:
        image_bytes = await file.read()
        img = read_image(image_bytes)
        unknown_encoding = encode_face(img)

        employees = db.query(Employee).filter(Employee.face_encoding != None).all()

        known_encodings = [np.frombuffer(emp.face_encoding, dtype=np.float64) for emp in employees]
        employee_ids = [emp.employee_id for emp in employees]

        best_match_index, distance = find_best_match(known_encodings, unknown_encoding)

        if is_match(known_encodings[best_match_index], unknown_encoding):
            employee_id = employee_ids[best_match_index]
            today = date.today()
            attendance = db.query(Attendance).filter_by(employee_id=employee_id, attendance_date=today).first()

            if attendance:
                return JSONResponse(status_code=400, content={"detail": "Already clocked in today."})

            now = datetime.now().time()
            new_attendance = Attendance(
                employee_id=employee_id,
                clock_in=now,
                clock_in_latitude=latitude,
                clock_in_longitude=longitude,
                clock_in_verified=True,
                attendance_date=today,
                attendance_status="Present",
                face_verified=True
            )
            db.add(new_attendance)
            db.commit()

            return {
                "message": "Clock-in success",
                "employee_id": employee_id,
                "clock_in_time": now.strftime("%H:%M:%S")
            }
        else:
            return JSONResponse(status_code=401, content={"detail": "Face not recognized."})

    except ValueError as ve:
        return JSONResponse(status_code=400, content={"detail": str(ve)})
    except Exception as e:
        return JSONResponse(status_code=500, content={"detail": "Internal server error."})