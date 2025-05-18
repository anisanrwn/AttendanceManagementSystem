from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.utils.auth import get_current_user
from app.database import get_db
from app.schemas import UserOut  # Schema Pydantic untuk output user

router = APIRouter()

@router.get("/users/me", response_model=UserOut)
def read_current_user(current_user=Depends(get_current_user)):
    return current_user
