from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List
from datetime import datetime, date
from app.utils.auth import get_current_user

router = APIRouter(prefix="/lock", tags=["lock"])

@router.get("/view", response_model=List[s.RoleLockStatus])
def view_role_lock_status(db: Session = Depends(get_db)):
    today = date.today()

    roles = db.query(m.Roles).options(joinedload(m.Roles.locks)).all()
    result = []

    for role in roles:
        is_locked = any(
            lock.start_date <= today <= lock.end_date
            for lock in role.locks
        )
        result.append(
            s.RoleLockStatus(
                roles_id=role.roles_id,
                roles_name=role.roles_name,
                status=not is_locked       # False ⇒ Locked, True ⇒ Active
            )
        )
    return result


@router.post("/manage")
async def manage_role_lock(request: s.ManageRoleLock, db: Session = Depends(get_db),
                           current_user: m.User = Depends(get_current_user)):

    start_date = datetime.fromisoformat(request.start_date).date()
    end_date   = datetime.fromisoformat(request.end_date).date()

    if start_date >= end_date:
        raise HTTPException(status_code=400, detail="End date must be after start date")

    if request.action == "lock":
        lock = m.RoleLock(
            role_id    = request.role_id,
            start_date = start_date,
            end_date   = end_date,
            reason     = request.reason
        )
        db.add(lock)
        message = "Role locked successfully"
    else:
        db.query(m.RoleLock).filter(
            m.RoleLock.role_id == request.role_id,
            m.RoleLock.end_date >= date.today()
        ).delete(synchronize_session=False)
        message = "Role unlocked successfully"

    db.commit()
    
    role = db.query(m.Roles).get(request.role_id)
    action = f"{'Locked' if request.action == 'lock' else 'Unlocked'} role {role.roles_name}"
    
    
    return {"message": message}
