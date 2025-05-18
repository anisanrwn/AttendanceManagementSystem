from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s

router = APIRouter()

@router.post("/permissions/request")
def request_permission(permission: s.PermissionCreate, db: Session = Depends(get_db)):
    new_permission = m.Permission(
        employee_id=permission.employee_id,
        permission_type=permission.permission_type,
        request_date=permission.request_date,
        start_date=permission.start_date,
        end_date=permission.end_date,
        reason=permission.reason,
        permission_status="Pending"
    )
    db.add(new_permission)
    db.commit()
    db.refresh(new_permission)

    employee = db.query(m.User).filter(m.User.user_id == permission.employee_id).first()
    if employee:
        employee_name = f"{employee.fname} {employee.lname}"
    else:
        employee_name = f"Employee ID {permission.employee_id}"

    users_with_role_2 = db.query(m.User).filter(m.User.role_id == 2).all()

    if not users_with_role_2:
        print("Tidak ada user dengan role_id=2 ditemukan!")

    for user in users_with_role_2:
        try:
            notification = m.Notification(
                user_id=user.user_id,
                title="Permintaan Izin Baru",
                message=f"Ada permintaan izin baru dari {employee_name}.",
                notification_type="permission",
                created_at=datetime.utcnow()
            )
            db.add(notification)
            print(f"Tambah notifikasi untuk user_id={user.user_id}")
        except Exception as e:
            print(f"Gagal tambah notifikasi untuk user_id={user.user_id}: {e}")

    try:
        db.commit()
        print("Commit notifikasi berhasil")
    except Exception as e:
        print(f"Commit notifikasi gagal: {e}")
        db.rollback()

    return {"message": "Permission request submitted and notifications sent to role_id 2 users."}
