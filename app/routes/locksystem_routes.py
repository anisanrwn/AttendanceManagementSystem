from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.logger import log_activity
from typing import List
from datetime import datetime

router = APIRouter(prefix="/lock", tags=["lock"])

@router.get("/view", response_model=List[s.RoleLockStatus])
def view_role_lock_status(db: Session = Depends(get_db)):
    roles = db.query(m.Roles).options(joinedload(m.Roles.locks)).all()
    
    result = []
    for role in roles:
        is_locked = any(
            lock.start_date <= datetime.utcnow() <= lock.end_date
            for lock in role.locks
        )
        result.append(s.RoleLockStatus(
            roles_id=role.roles_id,
            roles_name=role.roles_name,
            status=not is_locked 
        ))
    return result
