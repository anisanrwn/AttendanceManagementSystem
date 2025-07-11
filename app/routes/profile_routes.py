from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s

router = APIRouter(prefix="/profile", tags=["Profile"])

@router.get("/{user_id}", response_model=s.UserRead)
def get__profile(user_id: int, db: Session = Depends(get_db)):
    user = db.query(m.User).filter(m.User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
