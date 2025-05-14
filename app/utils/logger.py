from app.models import model as m
from sqlalchemy.orm import Session

def log_activity(db: Session, action: str, detail: str = None, user_id: int = None, ip_address: str = None):
    log = m.ActivityLog(
        action=action,
        detail=detail,
        user_id=user_id,
        ip_address=ip_address
    )
    db.add(log)
    db.commit()
