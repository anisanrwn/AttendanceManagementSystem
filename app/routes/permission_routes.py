from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.auth import verify_token, get_current_user

router = APIRouter()

@router.post("/permissions/request")
async def request_permission(
    permission: s.PermissionCreate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    # Dapatkan employee_id dari user yang login
    user = db.query(m.User).filter(m.User.user_id == current_user.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Buat permission baru
    new_permission = m.Permission(
        user_id=current_user.user_id,
        employee_id=user.employee_id,
        permission_type=permission.permission_type,
        request_date=permission.request_date or datetime.utcnow().date(),
        start_date=permission.start_date,
        end_date=permission.end_date,
        reason=permission.reason,
        permission_status="Pending"
    )
    
    db.add(new_permission)
    db.commit()
    db.refresh(new_permission)

    # Kirim notifikasi ke admin
    await send_notification_to_admins(db, user.employee_id)
    
    return {"message": "Permission request submitted successfully"}

async def send_notification_to_admins(db: Session, employee_id: int):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    employee_name = f"{employee.first_name} {employee.last_name}" if employee else f"Employee ID {employee_id}"

    admin_users = db.query(m.User).join(m.UserRoles).filter(m.UserRoles.roles_id == 2).all()

    for admin in admin_users:
        notification = m.Notification(
            user_id=admin.user_id,
            title="Permintaan Izin Baru",
            message=f"Ada permintaan izin baru dari {employee_name}.",
            notification_type="permission",
            created_at=datetime.utcnow() + timedelta(hours=7)
        )
        db.add(notification)
    
    try:
        db.commit()
    except Exception as e:
        db.rollback()
        print(f"Error sending notifications: {e}")