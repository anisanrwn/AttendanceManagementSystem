from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from fastapi import Request
from jose import jwt, JWTError
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.utils.messages import HTTPExceptionMessages as HM



def create_activity_log(
    db: Session,
    request: Request,
    user_id: int,
    action: str,
    detail: str = None
):
    ip_address = request.client.host
    device = request.headers.get("user-agent")

    log = m.ActivityLog(
        user_id=user_id,
        action=action,
        detail=detail,
        ip_address=ip_address,
        device=device
    )
    db.add(log)
    db.commit()
    db.refresh(log)
    return log