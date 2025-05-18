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

