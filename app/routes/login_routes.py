from fastapi import APIRouter, Depends, HTTPException, Form, Request, Body
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import func
from user_agents import parse
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from datetime import datetime, timedelta, timezone
from app.utils.verifpass import verify_password
from app.utils.attendance import mark_absent_for_missing_days
from app.services.activity_log import create_activity_log  
from app.utils.messages import HTTPExceptionMessages as HM
from app.utils.auth import verify_token, create_access_token, create_refresh_token
from app.core.config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
import json
import asyncio
from jose import jwt
import pytz
import random
import string
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import Optional
from fastapi import BackgroundTasks 




router = APIRouter(
    prefix="/login",
    tags=["Login"]
)

EMAIL_ADDRESS = "hrsystem812@gmail.com"  
EMAIL_PASSWORD = "dfxhwuyiwqszauxh"   
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587

otp_storage = {}

def generate_otp():
    return ''.join(random.choices(string.digits, k=6))

def send_otp_email(email, otp):

    try:
        message = MIMEMultipart()
        message["From"] = EMAIL_ADDRESS
        message["To"] = email
        message["Subject"] = "Verification Code for Attendance System Login"
        
        body = f"""
        <html>
        <body>
            <h2>Verification Code Login</h2>
            <p>Here is your OTP code to login:</p>
            <h1 style="background-color: #f2f2f2; padding: 10px; font-family: monospace; letter-spacing: 5px;">{otp}</h1>
            <p>The code is valid for 5 minutes.</p>
            <p>If you did not request this code, ignore this email.</p>
        </body>
        </html>
        """
        
        message.attach(MIMEText(body, "html"))
        
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        server.send_message(message)
        server.quit()
        return True
    except Exception as e:
        print(f"Error mengirim email: {e}")
        return False
    
def send_new_device_email(to_email: str, ip_address: str, device: str):
    try:
        email_message = MIMEMultipart()
        email_message["From"] = EMAIL_ADDRESS
        email_message["To"] = to_email
        email_message["Subject"] = "Login Detected from New Device - Attendance System"

        email_body = f"""
        <html>
        <body>
            <h2>New Device Login Notification</h2>
            <p>We've detected a login from a new device:</p>
            <ul>
                <li><strong>IP Address:</strong> {ip_address}</li>
                <li><strong>Device:</strong> {device}</li>
            </ul>
            <p>If this was you, you can safely ignore this message.</p>
            <p>If this wasn't you, we recommend changing your password immediately.</p>
            <p>To change your password or if you need further assistance, please contact your HR or IT department responsible for managing the application.</p>
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
        # log saja; jangan blokir alur utama
        print(f"[BG-TASK] gagal kirim email new-device: {e}")

@router.get("/notifications/stream")
async def notification_stream(
    request: Request, 
    user_id: int = Depends(verify_token),
    db: Session = Depends(get_db)
):
    async def event_generator():
        try:
            last_id = db.query(func.max(m.Notification.notification_id)).filter(
                m.Notification.user_id == user_id['user_id']
            ).scalar() or 0

            while True:
                if await request.is_disconnected():
                    print(f"Connection closed for user {user_id['user_id']}")
                    break

                new_notifications = db.query(m.Notification)\
                    .filter(
                        m.Notification.user_id == user_id['user_id'],
                        m.Notification.notification_id > last_id
                    )\
                    .order_by(m.Notification.notification_id.asc())\
                    .all()

                if new_notifications:
                    print(f"Found {len(new_notifications)} new notifications")
                    last_id = new_notifications[-1].notification_id

                    for notification in new_notifications:
                        data = {
                            'type': 'new_notification',
                            'notification': {
                                'notification_id': notification.notification_id,
                                'title': notification.title,
                                'message': notification.message,
                                'created_at': notification.created_at.isoformat(),
                                'is_read': notification.is_read,
                                'notification_type': notification.notification_type
                            }
                        }
                        yield f"data: {json.dumps(data)}\n\n"

                yield ": heartbeat\n\n"
                await asyncio.sleep(5)

        except Exception as e:
            print(f"SSE Error: {str(e)}")
            yield f"event: error\ndata: {json.dumps({'error': str(e)})}\n\n"

    return StreamingResponse(
        event_generator(),
        media_type="text/event-stream",
        headers={
            "Cache-Control": "no-cache",
            "Connection": "keep-alive",
            "X-Accel-Buffering": "no",
            "Access-Control-Allow-Origin": "*"
        }
    )

@router.get("/notifications/history")
def get_notification_history(
    user_id: int = Depends(verify_token),
    limit: int = 20, 
    db: Session = Depends(get_db)
):
    notifications = (
        db.query(m.Notification)
        .filter(m.Notification.user_id == user_id['user_id'])
        .order_by(m.Notification.created_at.desc())
        .limit(limit)
        .all()
    )

    return [
        {
            "notification_id": notif.notification_id,
            "title": notif.title,
            "message": notif.message,
            "created_at": notif.created_at.isoformat(),
            "is_read": notif.is_read,
            "notification_type": notif.notification_type
        }
        for notif in notifications
    ]

@router.post("/notifications/mark-as-read/{notification_id}")
def mark_as_read(
    notification_id: int,
    current_user: dict = Depends(verify_token),
    db: Session = Depends(get_db)
):
    notification = db.query(m.Notification).filter(
        m.Notification.notification_id == notification_id,
        m.Notification.user_id == current_user['user_id']
    ).first()

    if not notification:
        raise HTTPException(
            status_code=404,
            detail=HM.NOTIFICATION_NOT_FOUND
        )

    notification.is_read = True
    notification.read_at = datetime.utcnow()
    db.commit()
    
    return {"message": "Notification marked as read"}

@router.get("/auth/check")
async def check_auth(current_user: dict = Depends(verify_token)):
    return {
        "user_id": current_user['user_id'],
        "is_authenticated": True
    }

@router.post("/refresh-token")
async def refresh_token(refresh_token: str = Body(...), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(refresh_token, SECRET_KEY, algorithms=[ALGORITHM])
        
        if payload.get("type") != "refresh":
            raise HTTPException(status_code=401, detail=HM.INVALID_TOKEN_TYPE)
            
        user_id = payload.get("sub")
        user = db.query(m.User).filter(m.User.user_id == user_id).first()
        
        if not user:
            raise HTTPException(status_code=404, detail=HM.USER_NOT_FOUND)
            
        # Create new access token
        access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = jwt.encode(
            {
                "sub": str(user.user_id),
                "exp": datetime.utcnow() + access_token_expires,
                "user_id": user.user_id,
                "email": user.email,
                "roles": [role.roles_name for role in user.roles]
            },
            SECRET_KEY,
            algorithm=ALGORITHM
        )
        
        return {"access_token": access_token, "token_type": "bearer"}
        
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail=HM.REFRESH_TOKEN_EXPIRED)
    except jwt.JWTError:
        raise HTTPException(status_code=401, detail=HM.INVALID_REFRESH_TOKEN)

@router.post("/login")
async def login_user(
    request: Request,
    email: str = Form(...),
    password: str = Form(...),
    db: Session = Depends(get_db)
):
    ip_address = request.headers.get("x-forwarded-for", request.client.host)
    raw_user_agent = request.headers.get("user-agent", "unknown")
    user_agent_parsed = parse(raw_user_agent)
    browser_name = f"{user_agent_parsed.browser.family} {user_agent_parsed.browser.version_string}".strip()
    os_name = user_agent_parsed.os.family
    device_name = user_agent_parsed.device.family

    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(email=email).first()

    attempt = (
        db.query(m.LoginAttempt)
        .filter_by(email=email, ip_address=ip_address)
        .order_by(m.LoginAttempt.attempt_time.desc())
        .first()
    )

    now = datetime.utcnow()

    if attempt:
        if attempt.lockout_until and now < attempt.lockout_until:
            lockout_utc = attempt.lockout_until
            
            if lockout_utc.tzinfo is None:
                lockout_utc = lockout_utc.replace(tzinfo=timezone.utc)

            jakarta_tz = pytz.timezone("Asia/Jakarta")
            lockout_local = lockout_utc.astimezone(jakarta_tz)

            raise HTTPException(
                status_code=403,
                detail=HM.ACCOUNT_LOCKED.format(time=lockout_local.strftime('%H:%M:%S'))
            )
        if attempt.failed_attempts >= 10:
            raise HTTPException(
                status_code=403,
                detail=HM.ACCOUNT_LOCKED.format(time=lockout_local.strftime('%H:%M:%S'))
            )

    if user:
        current_time = datetime.utcnow()
        locks = db.query(m.RoleLock).filter(
            m.RoleLock.role_id.in_([role.roles_id for role in user.roles]),
        ).all()

        if locks:
            raise HTTPException(status_code=403, detail=HM.ROLE_LOCKED)
        
    

    if not user or not verify_password(password, user.password):
        if attempt and (now - attempt.attempt_time) < timedelta(minutes=30):
            attempt.failed_attempts += 1
        else:
            attempt = m.LoginAttempt(
                user_id=user.user_id if user else None,
                email=email,
                ip_address=ip_address,
                user_agent=browser_name,
                failed_attempts=1
            )
            db.add(attempt)

        if attempt.failed_attempts == 5:
            attempt.lockout_until = now + timedelta(minutes=5)
            if user:
                locked_until_str = (attempt.lockout_until + timedelta(hours=7)).strftime('%H:%M:%S')
                message = f"Detected 5 failed login attempts. Your account has been locked until {locked_until_str}."
                notification = m.Notification(
                    user_id=user.user_id,
                    title="Failed Login Attempt",
                    message = message,
                    notification_type="failed_login",
                    created_at=datetime.utcnow() + timedelta(hours=7)
                )
                db.add(notification)
                try:
                    email_message = MIMEMultipart()
                    email_message["From"] = EMAIL_ADDRESS
                    email_message["To"] = user.email
                    email_message["Subject"] = "Account Locked - Attendance System"

                    email_body = f"""
                    <html>
                    <body>
                        <h2>Account Locked Notification</h2>
                        <p>We detected <strong>5 failed login attempts</strong> on your account.</p>
                        <p>Your account has been temporarily locked until <strong>{locked_until_str}</strong>.</p>
                        <p>If this was not you, please contact your HR or IT department responsible for managing the application immediately.</p>
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
                    print(f"Failed to Send Email lockout: {e}")

        if attempt.failed_attempts >= 10:
            attempt.lockout_until = now + timedelta(hours=1)
            if user:
                locked_until_str = (attempt.lockout_until + timedelta(hours=7)).strftime('%H:%M:%S')
                message = f"Detected 10 failed login attempts. Your account has been locked until {locked_until_str}."
                notification = m.Notification(
                    user_id=user.user_id,
                    title="Failed Login Attempt",
                    message = message,
                    notification_type="failed_login",
                    created_at=datetime.utcnow() + timedelta(hours=7)
                )
                db.add(notification)
                try:
                    email_message = MIMEMultipart()
                    email_message["From"] = EMAIL_ADDRESS
                    email_message["To"] = user.email
                    email_message["Subject"] = "Account Locked - Attendance System"

                    email_body = f"""
                    <html>
                    <body>
                        <h2>Account Locked Notification</h2>
                        <p>We detected <strong>10 failed login attempts</strong> on your account.</p>
                        <p>Your account has been temporarily locked until <strong>{locked_until_str}</strong>.</p>
                        <p>If this was not you, please contact your HR or IT department responsible for managing the application immediately.</p>
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
                    print(f"Failed to Send Email lockout: {e}")

        db.commit()
        raise HTTPException(status_code=401, detail=HM.UNAUTHORIZED)
    
    otp = generate_otp()
    expiry_time = datetime.utcnow() + timedelta(minutes=5)
    otp_storage[email] = {
        'otp': otp,
        'expiry': expiry_time,
        'user_id': user.user_id,
        'ip_address': ip_address,
        'user_agent': browser_name
    }

    if not send_otp_email(email, otp):
        raise HTTPException(status_code=500, detail="Failed to send OTP code. Please try again.")

    # Catat login attempt belum berhasil (menunggu OTP)
    new_attempt = m.LoginAttempt(
        user_id=user.user_id,
        email=email,
        ip_address=ip_address,
        user_agent=browser_name,
        failed_attempts=0,
        is_successful=False,
    )
    db.add(new_attempt)
    db.commit()

    return {
        "status": "otp_required",
        "message": "The OTP code has been sent to your email",
        "email": email
    }


@router.post("/verify-otp")
async def verify_otp(
    request: Request,
    background_tasks: BackgroundTasks,
    email: str = Form(...),
    otp: str = Form(...), 
    db: Session = Depends(get_db)
):
    ip_address = request.headers.get("x-forwarded-for", request.client.host)
    raw_user_agent = request.headers.get("user-agent", "unknown")
    user_agent_parsed = parse(raw_user_agent)
    browser_name = f"{user_agent_parsed.browser.family} {user_agent_parsed.browser.version_string}".strip()

    if email not in otp_storage:
        raise HTTPException(status_code=400, detail="OTP session not found. Please login again.")

    stored_data = otp_storage[email]
    stored_otp = stored_data['otp']
    expiry_time = stored_data['expiry']
    user_id = stored_data['user_id']

    if datetime.utcnow() > expiry_time:
        del otp_storage[email]
        raise HTTPException(status_code=400, detail="OTP code has expired. Please login again.")

    if otp != stored_otp:
        raise HTTPException(status_code=400, detail="Incorrect OTP code.")

    del otp_storage[email]

    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(user_id=user_id).first()

   
    access_token = create_access_token(data={"sub": user.email, "user_id": user.user_id})
    refresh_token = create_refresh_token(data={"sub": user.email, "type": "refresh"})

    new_attempt = m.LoginAttempt(
        user_id=user.user_id,
        email=email,
        ip_address=ip_address,
        is_successful=True,
        user_agent=browser_name,
        failed_attempts=0
    )
    db.add(new_attempt)

    last_success = (
        db.query(m.LoginAttempt)
        .filter(
            m.LoginAttempt.user_id == user.user_id,
            m.LoginAttempt.is_successful == True
        )
        .order_by(m.LoginAttempt.attempt_time.desc())
        .first()
    )

    if last_success:
        if (
            last_success.ip_address != ip_address or
            last_success.user_agent != browser_name
        ):
            notification = m.Notification(
                user_id=user.user_id,
                title="Login from New Device",
                message=f"Login detected from IP: {ip_address}, Device: {browser_name}",
                notification_type="new_device",
                created_at=datetime.utcnow() + timedelta(hours=7)
            )
            db.add(notification)
            background_tasks.add_task(
                send_new_device_email, user.email, ip_address, browser_name
            )

        

    db.commit()
    mark_absent_for_missing_days(db, user.employee_id)
    
    create_activity_log(
        db=db,
        request=request,
        user_id=user.user_id,
        action="Login",
        detail=f"User {user.email} logged in successfully"
    )
    
    user_dict = {
        "user_id": user.user_id,
        "email": user.email,
        "employee_id": user.employee_id,
        "roles": [{"roles_name": role.roles_name} for role in user.roles],
        "access_token": access_token,
        "refresh_token": refresh_token
    }
    
    return user_dict

@router.post("/resend-otp")
async def resend_otp(
    email: str = Form(...),
    db: Session = Depends(get_db)
):
    if email not in otp_storage:
        raise HTTPException(status_code=400, detail="OTP session not found. Please login again.")

    otp = generate_otp()
    expiry_time = datetime.utcnow() + timedelta(minutes=5)
    user_id = otp_storage[email]['user_id']
    ip_address = otp_storage[email]['ip_address']
    user_agent = otp_storage[email]['user_agent']

    otp_storage[email] = {
        'otp': otp,
        'expiry': expiry_time,
        'user_id': user_id,
        'ip_address': ip_address,
        'user_agent': user_agent
    }

    if not send_otp_email(email, otp):
        raise HTTPException(status_code=500, detail="Failed to send OTP code. Please try again.")

    return {"status": "success", "message": "The new OTP code has been sent to your email"}