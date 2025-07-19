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
    roles = db.query(m.Roles).options(joinedload(m.Roles.locks)).all()
    result = []

    for role in roles:
        is_locked = bool(role.locks) 
        result.append(
            s.RoleLockStatus(
                roles_id=role.roles_id,
                roles_name=role.roles_name,
                status=not is_locked  
            )
        )
    return result



@router.post("/manage")
async def manage_role_lock(request: s.ManageRoleLock, db: Session = Depends(get_db),
                           current_user: m.User = Depends(get_current_user)):

    if request.action == "lock":
        # Check if there’s any lock data for each role
        existing = db.query(m.RoleLock).filter_by(role_id=request.role_id).first()
        if not existing:
            db.add(m.RoleLock(role_id=request.role_id))
            message = "Role locked successfully"
        else:
            message = "Role is already locked"
    else:
        db.query(m.RoleLock).filter_by(role_id=request.role_id).delete()
        message = "Role unlocked successfully"

    db.commit()
    role = db.query(m.Roles).get(request.role_id)
    return {"message": f"{message} ({role.roles_name})"}


    
