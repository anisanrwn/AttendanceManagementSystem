from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import datetime
from app.database import get_db
from app.models import model as m
from app.utils.email import send_email 

router = APIRouter(prefix="/permissionlist", tags=["Permission List"])

@router.get("/permissions/list")
def get_all_permissions(db: Session = Depends(get_db)):
    try:
        permissions = db.query(m.Permission).join(m.Employee, m.Permission.employee_id == m.Employee.employee_id).all()

        permission_list = []
        for p in permissions:
            permission_list.append({
                "permissions_id": p.permissions_id,
                "employee_name": f"{p.employee.first_name} {p.employee.last_name}" if p.employee else "Unknown",
                "permission_type": p.permission_type,
                "request_date": p.request_date.strftime("%Y-%m-%d") if p.request_date else None,
                "start_date": p.start_date.strftime("%Y-%m-%d") if p.start_date else None,
                "end_date": p.end_date.strftime("%Y-%m-%d") if p.end_date else None,
                "reason": p.reason,
                "permission_status": p.permission_status,
                "approved_date": p.approved_date.strftime("%Y-%m-%d") if p.approved_date else None,
            })

        return {"permissions": permission_list}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch permissions: {str(e)}")
    
    
@router.put("/permissions/{permission_id}/{action}")
def update_permission_status(permission_id: int, action: str, db: Session = Depends(get_db)):
    permission = db.query(m.Permission).filter(m.Permission.permissions_id == permission_id).first()

    if not permission:
        raise HTTPException(status_code=404, detail="Permission not found")

    if permission.permission_status != "Pending":
        raise HTTPException(status_code=400, detail="Permission already processed")

    if action not in ["approved", "declined"]:
        raise HTTPException(status_code=400, detail="Invalid action")

    permission.permission_status = "Approved" if action == "approved" else "Declined"
    permission.approved_date = datetime.utcnow().date()
    db.commit()

    user = db.query(m.User).filter(m.User.user_id == permission.user_id).first()
    employee = db.query(m.Employee).filter(m.Employee.employee_id == permission.employee_id).first()

    if user and employee:
        subject = "Status of Permission Request"
        status_str = "Approved" if action == "approved" else "Declined"
        body = f"Dear {employee.first_name},\n\nYour permission request has been {status_str} from HR.\n\nBest Regards, \n\nHRD PT United Tractors Jambi."
        send_email(user.email, subject, body)
        
    if action == "approved":
        from datetime import timedelta

        current_date = permission.start_date
        while current_date <= permission.end_date:
            attendance = db.query(m.Attendance).filter(
                m.Attendance.employee_id == permission.employee_id,
                m.Attendance.attendance_date == current_date
            ).first()

            if attendance:
                attendance.attendance_status = "Permit"
            else:
                new_attendance = m.Attendance(
                    employee_id=permission.employee_id,
                    attendance_date=current_date,
                    attendance_status="Permit"
                )
                db.add(new_attendance)

            current_date += timedelta(days=1)

        db.commit()

    return {
        "message": f"Permission has been {action}.",
        "approved_date": permission.approved_date.strftime("%Y-%m-%d")
    }
