from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.auth import get_current_user
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import smtplib

router = APIRouter()

EMAIL_ADDRESS = "hrsystem812@gmail.com"  
EMAIL_PASSWORD = "dfxhwuyiwqszauxh"   
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587

@router.post("/permissions/request")
async def request_permission(
    permission: s.PermissionCreate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    user = db.query(m.User).filter(m.User.user_id == current_user.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

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

    await send_notification_to_admins(db, user.employee_id)
    
    return {"message": "Permission request submitted successfully"}

async def send_notification_to_admins(db: Session, employee_id: int):
    employee = db.query(m.Employee).filter(m.Employee.employee_id == employee_id).first()
    employee_name = f"{employee.first_name} {employee.last_name}" if employee else f"Employee ID {employee_id}"

    admin_users = db.query(m.User).join(m.UserRoles).filter(m.UserRoles.roles_id == 2).all()

    for admin in admin_users:
        notification = m.Notification(
            user_id=admin.user_id,
            title="New Permission Request",
            message=f"There is a new permission request from {employee_name}.",
            notification_type="permission",
            created_at=datetime.utcnow() + timedelta(hours=7)
        )
        db.add(notification)
        try:
            email_message = MIMEMultipart()
            email_message["From"] = EMAIL_ADDRESS
            email_message["To"] = admin.email
            email_message["Subject"] = "New Permission Request - Attendance System"

            email_body = f"""
            <html>
            <body>
                <h2>New Permission Request</h2>
                <p>Dear Admin,</p>
                <p>A new permission request has been submitted by <strong>{employee_name}</strong>.</p>
                <p>Please review the request in the Attendance Management System.</p>
                <br>
                <p>Thank you,</p>
                <p><i>Attendance System - United Tractors</i></p>
            </body>
            </html>
            """

            email_message.attach(MIMEText(email_body, "html"))

            server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
            server.starttls()
            server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
            server.send_message(email_message)
            server.quit()
        except Exception as e:
            print(f"Failed Send Email to Admin {admin.email}: {e}")

    
    try:
        db.commit()
    except Exception as e:
        db.rollback()
        print(f"Error sending notifications: {e}")