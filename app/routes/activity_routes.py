from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from datetime import datetime
from app.models import model as m
from app.schemas import schemas as s
from app.utils.auth import get_current_user
from fastapi.responses import JSONResponse
from zoneinfo import ZoneInfo  

router = APIRouter( prefix="/activitylogs",
    tags=["Activity Logs"])

@router.get("/activity/logs", response_model=list[s.ActivityLogResponse])
def get_activity_logs(db: Session = Depends(get_db)):
    logs = db.query(m.ActivityLog).options(joinedload(m.ActivityLog.user)).order_by(m.ActivityLog.timestamp.desc()).all()
    results = []
    for log in logs:
        user = log.user
        if user:
            if user.employee:
                user_name = f"{user.employee.first_name} {user.employee.last_name}"
            else:
                user_name = user.username
            user_role_names = [role.roles_name for role in user.roles]
        else:
            user_name = "Unknown"
            user_role_names = []

        if "Superadmin" in user_role_names:
            user_role_class = "primary"
        elif any("Admin" in role_name for role_name in user_role_names):
            user_role_class = "info"
        else:
            user_role_class = "warning"

        results.append(s.ActivityLogResponse(
            timestamp=log.timestamp.astimezone(ZoneInfo("Asia/Jakarta")).strftime("%Y-%m-%d %H:%M:%S"),
            user_name=user_name,
            user_role_class=user_role_class,
            action=log.detail or log.action,  
            ip_address=log.ip_address or "-",  
            device=log.device or "-" 
        ))
    return results
