from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.logger import log_activity
from typing import List
from datetime import datetime
from app.utils.auth import get_current_user

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

@router.post("/manage")
async def manage_role_lock(
    request: s.ManageRoleLock,
    db: Session = Depends(get_db),
    current_user: m.User = Depends(get_current_user)
):
    # Check if action is valid
    if request.action not in ["lock", "unlock"]:
        raise HTTPException(status_code=400, detail="Invalid action")
    
    # Validate dates
    start_date = datetime.fromisoformat(request.start_date)
    end_date = datetime.fromisoformat(request.end_date)
    
    if start_date >= end_date:
        raise HTTPException(status_code=400, detail="End date must be after start date")
    
    if request.action == "lock":
        # Create new lock
        lock = m.RoleLock(
            role_id=request.role_id,
            start_date=start_date,
            end_date=end_date,
            reason=request.reason
        )
        db.add(lock)
        message = "Role locked successfully"
    else:
        # Remove active locks
        locks = db.query(m.RoleLock).filter(
            m.RoleLock.role_id == request.role_id,
            m.RoleLock.end_date >= datetime.utcnow()
        ).all()
        
        for lock in locks:
            db.delete(lock)
        message = "Role unlocked successfully"
    
    db.commit()
    
    # Log activity
    role = db.query(m.Roles).get(request.role_id)
    action = f"{'Locked' if request.action == 'lock' else 'Unlocked'} role {role.roles_name}"
    log_activity(db, current_user.user_id, action, f"From {start_date} to {end_date}. Reason: {request.reason}")
    
    return {"message": message}
