from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from app.database import get_db
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List
from datetime import datetime, date
from app.models.model import BackupSchedule




router = APIRouter(prefix="/api")

# Schema untuk validasi input dari client
class BackupScheduleSchema(BaseModel):
    intervalMinutes: int
    startTime: str

@router.get("/backup/schedule")
def get_schedule_for_script(db: Session = Depends(get_db)):
    schedule = db.query(BackupSchedule).first()
    if not schedule:
        raise HTTPException(status_code=404, detail="No schedule found")
    return {
        "interval_minutes": schedule.interval_minutes,
        "start_time": schedule.start_time
    }


@router.post("/save-backup-schedule")
def save_backup_schedule(data: BackupScheduleSchema, db: Session = Depends(get_db)):
    existing = db.query(BackupSchedule).first()
    if existing:
        existing.interval_minutes = data.intervalMinutes
        existing.start_time = data.startTime
    else:
        new_schedule = BackupSchedule(
            interval_minutes=data.intervalMinutes,
            start_time=data.startTime
        )
        db.add(new_schedule)
    db.commit()
    return {"message": "Schedule saved successfully"}
