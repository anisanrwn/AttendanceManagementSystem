from fastapi import Request
from sqlalchemy.orm import Session
from typing import Optional
from app.models import model as m

def create_activity_log(
    db: Session,
    request: Optional[Request],  
    action: str,
    detail: Optional[str] = None,
    user_id: Optional[int] = None,
):
    try:
        ip_address = request.client.host if request and request.client else "unknown"
        device = request.headers.get("user-agent", "unknown") if request else "unknown"

        log = m.ActivityLog(
            action=action,
            detail=detail,
            ip_address=ip_address,
            device=device,
            user_id=user_id
        )

        db.add(log)
        db.commit()
        db.refresh(log)
        return log
    except Exception as e:
        db.rollback()
        print(f"Failed to create activity log: {e}")
