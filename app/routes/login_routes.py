from fastapi import APIRouter, Depends, HTTPException, Form, Path
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List, Optional

router = APIRouter(
    prefix="/login",
    tags=["Login"]
)


@router.post("/login", response_model=s.UserRead)
async def login_user(email: str = Form(...), password: str = Form(...), db: Session = Depends(get_db)):
    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(email=email).first()
    
    if not user or user.password != password:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    return user



