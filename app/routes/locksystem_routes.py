from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List
from datetime import datetime, date
from app.utils.auth import get_current_user
from app.services.activity_log import create_activity_log
from app.utils.auth_log import get_current_user  

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
async def manage_role_lock(
    request_data: s.ManageRoleLock,
    request: Request,
    db: Session = Depends(get_db),
    current_user: m.User = Depends(get_current_user)
):
    try:
        if request_data.action == "lock":
            existing = db.query(m.RoleLock).filter_by(role_id=request_data.role_id).first()
            if not existing:
                db.add(m.RoleLock(role_id=request_data.role_id))
                message = "Role locked successfully"
            else:
                message = "Role is already locked"
        else:
            db.query(m.RoleLock).filter_by(role_id=request_data.role_id).delete()
            message = "Role unlocked successfully"

        db.commit()

        role = db.query(m.Roles).get(request_data.role_id)

        # ✅ Tambahkan log activity
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Manage Role Lock",
            detail=f"{message} for role: {role.roles_name} by {current_user.username}"
        )

        return {"message": f"{message} ({role.roles_name})"}

    except Exception as e:
        db.rollback()
        create_activity_log(
            db=db,
            request=request,
            user_id=current_user.user_id,
            action="Manage Role Lock Failed",
            detail=str(e)
        )
        raise HTTPException(status_code=500, detail="Failed to manage role lock")

