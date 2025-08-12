from fastapi import APIRouter, Depends, HTTPException, Form, Request, Body
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import func
from user_agents import parse
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.auth import get_current_user
from datetime import datetime, timedelta, timezone
from app.utils.verifpass import verify_password
from app.utils.attendance import mark_absent_for_missing_days
from app.services.activity_log import create_activity_log  
from app.utils.messages import HTTPExceptionMessages as HM
from app.utils.security import generate_qr_code, verify_mfa_token, generate_mfa_secret
from app.utils.auth import verify_token, create_access_token, create_refresh_token
from app.core.config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
import json
import asyncio
from jose import jwt
import pytz
import random
import pyotp
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import Optional
from fastapi import BackgroundTasks 
from app.utils.auth import ( verify_token, create_access_token, create_refresh_token, create_unlock_token, verify_unlock_token )
from fastapi.responses import HTMLResponse
from device_detector import DeviceDetector
from app.core.config import SECRET_KEY, ALGORITHM
import random
import jwt 
import pyotp
import qrcode
import io
import base64
import secrets
import string
from fastapi import HTTPException, status
from fastapi.responses import JSONResponse
from datetime import datetime, timedelta
import secrets
from sqlalchemy.orm import Session
from app.core.config import SECRET_KEY, ALGORITHM
from passlib.context import CryptContext


SECRET_KEY_COLOR = "SECRET"

router = APIRouter(
    prefix="/login",
    tags=["Login"]
)

EMAIL_ADDRESS = "hrsystem812@gmail.com"  
EMAIL_PASSWORD = "dfxhwuyiwqszauxh"   
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587

permanent_lock_tokens = {}
reset_password_tokens = {}
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    """Hash password using bcrypt"""
    return pwd_context.hash(password)

def verify_unlock_token(token: str):
    """Verify unlock token"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise jwt.ExpiredSignatureError("Token expired")
    except jwt.JWTError:
        raise jwt.JWTError("Invalid token")

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
        print(f"[BG-TASK] failed to send new-device email: {e}")


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
    background_tasks: BackgroundTasks,
    email: str = Form(...),
    password: str = Form(...),
    db: Session = Depends(get_db)
):
    ip_address = request.headers.get("x-forwarded-for", request.client.host)
    raw_user_agent = request.headers.get("user-agent", "unknown")
    dd = DeviceDetector(raw_user_agent).parse()
    browser_name = dd.client_name()

    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(email=email).first()

    # Check permanent lock
    if email in permanent_lock_tokens:
        raise HTTPException(status_code=423, detail="Your account is locked. Please check your email to unlock.")

    latest_attempt = (
        db.query(m.LoginAttempt)
        .filter_by(email=email)  
        .order_by(m.LoginAttempt.attempt_time.desc())
        .first()
    )

    now = datetime.utcnow()

    if latest_attempt and latest_attempt.lockout_until and now < latest_attempt.lockout_until:
        lockout_utc = latest_attempt.lockout_until
        if lockout_utc.tzinfo is None:
            lockout_utc = lockout_utc.replace(tzinfo=timezone.utc)
        jakarta_tz = pytz.timezone("Asia/Jakarta")
        lockout_local = lockout_utc.astimezone(jakarta_tz)
        
        raise HTTPException(
            status_code=423,
            detail={
                "type": "account_locked",
                "message": "Your account is currently locked",
                "locked_until": lockout_local.strftime('%H:%M:%S'),
                "attempts": latest_attempt.failed_attempts,
                "duration": "Please wait until the specified time"
            }
        )

    # Check for permanent lock (15+ attempts)
    if latest_attempt and latest_attempt.failed_attempts >= 15:
        if email not in permanent_lock_tokens:
            if user and latest_attempt.failed_attempts == 15:
                unlock_token = create_unlock_token(email)
                permanent_lock_tokens[email] = unlock_token
                unlock_link = f"http://localhost:8000/login/unlock-account?token={unlock_token}"
                send_permanent_lock_email(user.email, unlock_link)
        raise HTTPException(status_code=423, detail="Your account has been permanently locked. Check your email for verification.")

    # Check role locks
    if user:
        locks = db.query(m.RoleLock).filter(
            m.RoleLock.role_id.in_([role.roles_id for role in user.roles]),
        ).all()
        if locks:
            raise HTTPException(status_code=403, detail=HM.ROLE_LOCKED)

    if not user or not verify_password(password, user.password):
        if user:
            user.failed_login_count += 1
            
            if user.failed_login_count >= 1:
                user.requires_mfa_setup = True
                print(f"DEBUG: Set requires_mfa_setup=True for {email}, failed_count={user.failed_login_count}")
        
        if latest_attempt and (now - latest_attempt.attempt_time) < timedelta(minutes=5):
            latest_attempt.failed_attempts += 1
            latest_attempt.attempt_time = now  
            latest_attempt.ip_address = ip_address  
            latest_attempt.user_agent = browser_name  
            current_attempt = latest_attempt
        else:
            previous_failed_count = latest_attempt.failed_attempts if latest_attempt else 0
            
            current_attempt = m.LoginAttempt(
                user_id=user.user_id if user else None,
                email=email,
                ip_address=ip_address,
                user_agent=browser_name,
                failed_attempts=previous_failed_count + 1, 
                attempt_time=now
            )
            db.add(current_attempt)
        
        print(f"DEBUG: Failed attempt #{current_attempt.failed_attempts} for {email}")
        
        if current_attempt.failed_attempts == 5:
            current_attempt.lockout_until = now + timedelta(minutes=1)
            if user:
                lockout_utc = current_attempt.lockout_until
                if lockout_utc.tzinfo is None:
                    lockout_utc = lockout_utc.replace(tzinfo=timezone.utc)
                jakarta_tz = pytz.timezone("Asia/Jakarta")
                lockout_local = lockout_utc.astimezone(jakarta_tz)
                locked_until_str = lockout_local.strftime('%H:%M:%S')
                
                # Notification
                notification = m.Notification(
                    user_id=user.user_id,
                    title="Failed Login Attempt",
                    message=f"Detected 5 failed login attempts. Your account has been locked until {locked_until_str}.",
                    notification_type="failed_login",
                    created_at=datetime.utcnow() + timedelta(hours=7)
                )
                db.add(notification)
                
                # Activity log
                create_activity_log(
                    db=db,
                    request=request,
                    user_id=user.user_id,
                    action="Account Temporarily Locked",
                    detail=f"5 failed login attempts detected. Account using email {email} locked until {locked_until_str}."
                )
                
                # Email notification (existing code)
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
                        <p>If this was not you, please contact your HR or IT department immediately.</p>
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
                
                raise HTTPException(
                    status_code=401,  
                    detail={
                        "type": "account_locked",
                        "message": "Account locked due to 5 failed login attempts",
                        "locked_until": locked_until_str,
                        "attempts": 5,
                        "duration": "1 minute"
                    }
                )

        # Handle lockout at 10 failed attempts
        elif current_attempt.failed_attempts == 10:
            current_attempt.lockout_until = now + timedelta(minutes = 2)  
            if user:
                lockout_utc = current_attempt.lockout_until
                if lockout_utc.tzinfo is None:
                    lockout_utc = lockout_utc.replace(tzinfo=timezone.utc)
                jakarta_tz = pytz.timezone("Asia/Jakarta")
                lockout_local = lockout_utc.astimezone(jakarta_tz)
                locked_until_str = lockout_local.strftime('%H:%M:%S')
                
                # Notification
                notification = m.Notification(
                    user_id=user.user_id,
                    title="Failed Login Attempt",
                    message=f"Detected 10 failed login attempts. Your account has been locked until {locked_until_str}.",
                    notification_type="failed_login",
                    created_at=datetime.utcnow() + timedelta(hours=7)
                )
                db.add(notification)
                
                # Activity log
                create_activity_log(
                    db=db,
                    request=request,
                    user_id=user.user_id,
                    action="Account Temporarily Locked",
                    detail=f"10 failed login attempts detected. Account using email {email} locked until {locked_until_str}."
                )
                
                # Email notification (similar to 5 attempts)
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
                        <p>If this was not you, please contact your HR or IT department immediately.</p>
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
                
                raise HTTPException(
                    status_code=401,  
                    detail={
                        "type": "account_locked",
                        "message": "Account locked due to 10 failed login attempts",
                        "locked_until": locked_until_str,
                        "attempts": 10,
                        "duration": "1 hour"
                    }
                )
        
        # Create activity log for failed login
        create_activity_log(
            db=db,
            request=request,
            user_id=user.user_id if user else None,
            action="Failed Login",
            detail=f"Failed login attempt #{current_attempt.failed_attempts} using email {email}."
        )

        db.commit()  # Commit failed login changes
        raise HTTPException(status_code=401, detail=HM.UNAUTHORIZED)
    
    
    print(f"DEBUG LOGIN SUCCESS for {email}:")
    print(f"  - failed_login_count: {user.failed_login_count}")
    print(f"  - requires_mfa_setup: {user.requires_mfa_setup}")
    print(f"  - mfa_enabled: {user.mfa_enabled}")

    if user.requires_mfa_setup and not user.mfa_enabled:
        print(f"DEBUG: Requiring MFA setup for {email}")
        return {
            "status": "mfa_setup_required",
            "message": "MFA setup required due to previous failed login attempts",
            "email": email
        }

    if user.requires_mfa_setup and user.mfa_enabled:
        print(f"DEBUG: Requiring MFA verification for {email}")
        return {
            "status": "mfa_required",
            "message": "Please enter your Google Authenticator code", 
            "email": email
        }

    print(f"DEBUG: Direct login for {email} (no penalty)")
    
    if latest_attempt and latest_attempt.failed_attempts > 0:
        latest_attempt.failed_attempts = 0  
        latest_attempt.lockout_until = None  
        latest_attempt.is_successful = True   
        latest_attempt.attempt_time = now    
        latest_attempt.ip_address = ip_address
        latest_attempt.user_agent = browser_name
    else:
        new_successful_attempt = m.LoginAttempt(
            user_id=user.user_id,
            email=email,
            ip_address=ip_address,
            is_successful=True,
            user_agent=browser_name,
            failed_attempts=0,
            attempt_time=now
        )
        db.add(new_successful_attempt)
    
    user.failed_login_count = 0
    
    # Generate tokens
    access_token = create_access_token(data={"sub": user.email, "user_id": user.user_id})
    refresh_token = create_refresh_token(data={"sub": user.email, "type": "refresh"})

    # New device detection (existing logic)
    last_success = (
        db.query(m.LoginAttempt)
        .filter(
            m.LoginAttempt.user_id == user.user_id,
            m.LoginAttempt.is_successful == True
        )
        .order_by(m.LoginAttempt.attempt_time.desc())
        .offset(1)  # Skip current login
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


@router.post("/setup-mfa")
async def setup_mfa(
    email: str = Form(...),
    db: Session = Depends(get_db)
):
    """Generate QR code for MFA setup"""
    user = db.query(m.User).filter_by(email=email).first()
   
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
   
    if not user.requires_mfa_setup:
        raise HTTPException(status_code=400, detail="MFA setup not required for this user")
   
    # Generate secret if not exists
    if not user.mfa_secret:
        user.mfa_secret = generate_mfa_secret()  
        db.commit()
   
    qr_code_data_uri = generate_qr_code(user.email, user.mfa_secret, "Attendance System")
   
    return {
        "status": "qr_generated",
        "message": "Scan QR code with Google Authenticator",
        "qr_code": qr_code_data_uri,  
        "manual_entry_key": user.mfa_secret,  
        "email": email
    }


@router.post("/verify-mfa-setup")
async def verify_mfa_setup(
    request: Request,
    email: str = Form(...),
    mfa_code: str = Form(...),
    db: Session = Depends(get_db)
):
    """Verify and enable MFA for user"""
    user = db.query(m.User).filter_by(email=email).first()
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if not user.mfa_secret:
        raise HTTPException(status_code=400, detail="MFA not set up")
    
    # Verify the code
    if not verify_mfa_token(user.mfa_secret, mfa_code):
        raise HTTPException(status_code=400, detail="Invalid MFA code")
    
    user.mfa_enabled = True
    user.requires_mfa_setup = False  
    user.failed_login_count = 0    
    db.commit()
    
    create_activity_log(
        db=db,
        request=request,
        user_id=user.user_id,
        action="MFA Enabled",
        detail=f"User {user.email} enabled MFA after failed login penalty"
    )
    
    access_token = create_access_token(data={"sub": user.email, "user_id": user.user_id})
    refresh_token = create_refresh_token(data={"sub": user.email, "type": "refresh"})
    
    return {
        "status": "mfa_enabled_and_logged_in",
        "message": "MFA has been successfully enabled. You are now logged in.",
        "user_id": user.user_id,
        "email": user.email,
        "employee_id": user.employee_id,
        "roles": [{"roles_name": role.roles_name} for role in user.roles],
        "access_token": access_token,
        "refresh_token": refresh_token
    }


@router.post("/verify-mfa")
async def verify_mfa_login(
    request: Request,
    background_tasks: BackgroundTasks,
    email: str = Form(...),
    mfa_code: str = Form(...),
    db: Session = Depends(get_db)
):
    """Verify MFA code for login"""
    ip_address = request.headers.get("x-forwarded-for", request.client.host)
    raw_user_agent = request.headers.get("user-agent", "unknown")
    dd = DeviceDetector(raw_user_agent).parse()
    browser_name = dd.client_name()

    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(email=email).first()
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if not user.mfa_enabled or not user.mfa_secret:
        raise HTTPException(status_code=400, detail="MFA not enabled for this user")
    
    # Verify MFA code
    if not verify_mfa_token(user.mfa_secret, mfa_code):
        create_activity_log(
            db=db,
            request=request,
            user_id=user.user_id,
            action="Failed MFA Verification",
            detail=f"Invalid MFA code for user {user.email}"
        )
        raise HTTPException(status_code=400, detail="Invalid MFA code")
    
    user.requires_mfa_setup = False  
    user.failed_login_count = 0      

    access_token = create_access_token(data={"sub": user.email, "user_id": user.user_id})
    refresh_token = create_refresh_token(data={"sub": user.email, "type": "refresh"})

    
    new_successful_attempt = m.LoginAttempt(
        user_id=user.user_id,
        email=email,
        ip_address=ip_address,
        is_successful=True,
        user_agent=browser_name,
        failed_attempts=0
    )
    db.add(new_successful_attempt)

    # Check for new device (existing logic from original code)
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
    
    create_activity_log(
        db=db,
        request=request,
        user_id=user.user_id,
        action="MFA Login Success",
        detail=f"User {user.email} logged in successfully with MFA"
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


@router.post("/disable-mfa")
async def disable_mfa(
    request: Request,
    current_password: str = Form(...),
    mfa_code: str = Form(...),
    current_user: m.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Disable MFA for user (requires password + MFA code)"""
    
    # Verify current password
    if not verify_password(current_password, current_user.password):
        raise HTTPException(status_code=400, detail="Invalid password")
    
    # Verify MFA code
    if not verify_mfa_token(current_user.mfa_secret, mfa_code):
        raise HTTPException(status_code=400, detail="Invalid MFA code")
    
    # Disable MFA
    current_user.mfa_enabled = False
    current_user.mfa_secret = None
    current_user.requires_mfa_setup = False
    current_user.failed_login_count = 0
    db.commit()
    
    create_activity_log(
        db=db,
        request=request,
        user_id=current_user.user_id,
        action="MFA Disabled",
        detail=f"User {current_user.email} disabled MFA"
    )
    
    return {"status": "mfa_disabled", "message": "MFA has been disabled for your account"}



@router.get("/unlock-account")
async def unlock_account(
    token: str,
    request: Request,
    db: Session = Depends(get_db),
    user_answer: str = None,
    color_token: str = None
):
  
    if not user_answer:
        colors = [("BLUE", "red"), ("RED", "blue"), ("PURPLE", "green")]
        word, color = random.choice(colors)

        encoded_color = jwt.encode({"color": color}, SECRET_KEY_COLOR, algorithm="HS256")

        return HTMLResponse(content=f"""
        <!DOCTYPE html>
    <html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Color Verification</title>
        <style>
            body {{
                font-family: 'Segoe UI', sans-serif;
                background-color: #f8f6ff; /* putih lembut */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }}
            .container {{
                background: #ffffff;
                padding: 30px 40px;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                text-align: center;
                max-width: 350px;
                width: 100%;
            }}
            h2 {{
                margin-bottom: 20px;
                color: #6a0dad; /* ungu tua */
            }}
            .color-text {{
                font-size: 26px;
                font-weight: bold;
                margin: 15px 0;
            }}
            label {{
                font-weight: 500;
                color: #444;
            }}
            input[type="text"] {{
                padding: 10px;
                width: 80%;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin-top: 10px;
                font-size: 14px;
                outline-color: #6a0dad;
            }}
            button {{
                margin-top: 20px;
                background: #6a0dad;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 14px;
                transition: background 0.3s ease;
            }}
            button:hover {{
                background: #530a9c;
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Color Check</h2>
            <p class="color-text" style="color:{color};">{word}</p>
            <form method="get" action="{request.url.path}">
                <input type="hidden" name="token" value="{token}">
                <input type="hidden" name="color_token" value="{encoded_color}">
                
                <label>What is the color of the text above?</label><br>
                <input type="text" name="user_answer"  required>
                
                <br>
                <button type="submit">Verification</button>
            </form>
        </div>
    </body>
    </html>
        """, status_code=200)

    try:
        decoded = jwt.decode(color_token, SECRET_KEY_COLOR, algorithms=["HS256"])
        correct_color = decoded["color"]
    except jwt.PyJWTError:
        raise HTTPException(status_code=400, detail="Token warna tidak valid.")

    if user_answer.strip().lower() != correct_color.strip().lower():
        return HTMLResponse(content="<h1 style='text-align:center;'>Jawaban salah! Silakan coba lagi.</h1>", status_code=400)

    try:
        payload = verify_unlock_token(token)
        email = payload.get("sub")

        if payload.get("type") != "unlock":
            raise HTTPException(status_code=400, detail="Invalid token type.")

        user = db.query(m.User).filter(m.User.email == email).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found.")

        attempt = db.query(m.LoginAttempt)\
            .filter(m.LoginAttempt.email == email)\
            .order_by(m.LoginAttempt.attempt_time.desc())\
            .first()

        if attempt and attempt.failed_attempts >= 15:
            attempt.failed_attempts = 0
            attempt.lockout_until = None
            db.commit()

        if email in permanent_lock_tokens:
            del permanent_lock_tokens[email]
            
        create_activity_log(
            db=db,
            request=request,
            user_id=user.user_id,
            action="Account Unlocked",
            detail=f"User {user.email} unlocked their account via verification link."
        )

        # Halaman sukses
        return HTMLResponse(content=f"""
        <html>
            <head>
                <title>Account Unlocked</title>
                <style>
                    body {{
                        background-color: #f0f2f5;
                        font-family: 'Segoe UI', sans-serif;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                    }}
                    .card {{
                        background-color: white;
                        padding: 40px;
                        border-radius: 12px;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                        text-align: center;
                        max-width: 500px;
                    }}
                    .card h2 {{
                        color: #6f42c1;
                        margin-bottom: 10px;
                    }}
                    .card p {{
                        color: #333;
                        font-size: 16px;
                        line-height: 1.6;
                    }}
                    .btn {{
                        background-color: #007bff;
                        color: white;
                        padding: 12px 24px;
                        border: none;
                        border-radius: 6px;
                        text-decoration: none;
                        font-size: 16px;
                        display: inline-block;
                        margin-top: 20px;
                    }}
                    .btn:hover {{
                        background-color: #0056b3;
                    }}
                </style>
            </head>
            <body>
                <div class="card">
                    <h2>Your Account Has Been Unlocked!</h2>
                    <p>Your account is now active again. You can log in and continue using the system as usual.</p>
                </div>
            </body>
        </html>
        """, status_code=200)

    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=400, detail="Verification token has expired.")
    except jwt.JWTError:
        raise HTTPException(status_code=400, detail="Invalid verification token.")


def create_unlock_token(email: str):
    expire = datetime.utcnow() + timedelta(minutes=15)
    payload = {
        "sub": email,
        "type": "unlock",
        "exp": expire
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

@router.post("/login/send-unlock-verification")
async def send_unlock_verification(email: str = Form(...), db: Session = Depends(get_db)):
        user = db.query(m.User).filter(m.User.email == email).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found.")

        attempt = db.query(m.LoginAttempt).filter(m.LoginAttempt.email == email).order_by(m.LoginAttempt.attempt_time.desc()).first()
        if not attempt or attempt.failed_attempts < 15:
            raise HTTPException(status_code=400, detail="Account is not permanently locked.")
           
        token = create_unlock_token(email)
        permanent_lock_tokens[email] = token
        verify_link = f"http://localhost:8000/login/unlock-account?token={token}"


        if not send_permanent_lock_email(user.email, verify_link):
            raise HTTPException(status_code=500, detail="Failed to send verification email.")


        return {"message": "Unlock verification email sent successfully."}
   
def send_permanent_lock_email(to_email: str, verification_link: str):
    try:
        email_message = MIMEMultipart()
        email_message["From"] = EMAIL_ADDRESS
        email_message["To"] = to_email
        email_message["Subject"] = "Account Permanently Locked - Attendance System"


        email_body = f"""
        <html>
        <body>
            <h2>Account Permanently Locked</h2>
            <p>We detected <strong>15 failed login attempts</strong> on your account.</p>
            <p>Your account has been <strong>permanently locked</strong> as a security measure.</p>
            <p>To unlock your account, please click the link below to verify your identity:</p>
            <a href="{verification_link}" 
            style="
                display: inline-block;
                padding: 12px 24px;
                background-color: #6f42c1;
                color: white;
                text-decoration: none;
                font-weight: bold;
                border-radius: 6px;
                font-family: sans-serif;
            ">
            Unlock My Account
            </a>
            <p>If you did not request this, please contact the IT department immediately.</p>
        </body>
        </html>
        """
        email_message.attach(MIMEText(email_body, "html"))
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        server.send_message(email_message)
        server.quit()
        return True
    except Exception as e:
        print(f"Failed to send permanent lockout email: {e}")
        return False

def hash_password(password: str) -> str:
    """Hash password using bcrypt"""
    return pwd_context.hash(password)


def create_reset_token(email: str):
    """Create password reset token"""
    expire = datetime.utcnow() + timedelta(minutes=30)  # 30 minutes expiry
    payload = {
        "sub": email,
        "type": "reset", 
        "exp": expire,
        "iat": datetime.utcnow()
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)


def verify_reset_token(token: str):
    """Verify password reset token"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        
        if payload.get("type") != "reset":
            raise jwt.InvalidTokenError("Invalid token type")
            
        return payload
    except jwt.ExpiredSignatureError:
        raise jwt.ExpiredSignatureError("Reset token has expired")
    except jwt.InvalidTokenError:
        raise jwt.InvalidTokenError("Invalid reset token")
    except Exception as e:
        raise jwt.JWTError(f"Token verification failed: {str(e)}")


def send_reset_password_email(to_email: str, reset_link: str):
    """Send password reset email - Fixed to match working email function structure"""
    try:
        email_message = MIMEMultipart()
        email_message["From"] = EMAIL_ADDRESS
        email_message["To"] = to_email
        email_message["Subject"] = "Password Reset Request - Attendance System"

        email_body = f"""
        <html>
        <body>
            <h2>Password Reset Request</h2>
            <p>We received a request to reset the password for your account.</p>
            <p><strong>Email:</strong> {to_email}</p>
            <p>Click the link below to reset your password:</p>
            <a href="{reset_link}" 
               style="display: inline-block; padding: 12px 24px; background-color: #667eea; 
                      color: white; text-decoration: none; font-weight: bold; border-radius: 6px;">
                Reset My Password
            </a>
            <p><strong>Important:</strong></p>
            <ul>
                <li>This link expires in 30 minutes</li>
                <li>If you didn't request this, please ignore this email</li>
            </ul>
            <p>If this wasn't you, please contact your IT department immediately.</p>
        </body>
        </html>
        """

        email_message.attach(MIMEText(email_body, "html"))

        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        server.send_message(email_message)  
        server.quit()
        
        return True
        
    except Exception as e:
        return False

@router.post("/forgot-password")
async def forgot_password(
    request: Request,  
    email: str = Form(...),
    db: Session = Depends(get_db)
):
    """Initiate password reset process - FIXED"""
    
    # Find user
    user = db.query(m.User).filter(m.User.email == email).first()
    
    if not user:
        return {
            "status": "success",
            "message": "If the email exists in our system, a password reset link will be sent."
        }
    
    try:
        reset_token = create_reset_token(email)
        reset_password_tokens[email] = {
            "token": reset_token,
            "created_at": datetime.utcnow(),
            "user_id": user.user_id
        }
        
        reset_link = f"http://localhost:8000/login/reset-password?token={reset_token}"
        
        email_sent = send_reset_password_email(user.email, reset_link)
        
        if email_sent:
            create_activity_log(
                db=db,
                request=request,
                user_id=user.user_id,
                action="Password Reset Requested",
                detail=f"Password reset link sent to {email}"
            )
            
            return {
                "status": "success", 
                "message": "Password reset link has been sent to your email."
            }
        else:
            raise HTTPException(status_code=500, detail="Failed to send reset email")
            
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to process password reset request")

def validate_password_strength(password: str, email: str = None) -> tuple[bool, str]:
    """Validate password strength and requirements"""
    if len(password) < 8:
        return False, "Password must be at least 8 characters long"
    
    has_upper = any(c.isupper() for c in password)
    has_lower = any(c.islower() for c in password)
    has_digit = any(c.isdigit() for c in password)
    
    if not (has_upper and has_lower and has_digit):
        return False, "Password must contain at least one uppercase letter, one lowercase letter, and one number"
    
    if email:
        email_part = email.split('@')[0].lower()
        if email_part in password.lower():
            return False, "Password cannot contain your email address"
    
    return True, "Password is valid"

def check_password_history(user: m.User, new_password: str) -> bool:
    """Check if new password matches current password"""
    if verify_password(new_password, user.password):
        return False  
    return True  

@router.get("/reset-password")
async def reset_password_form(
    token: str,
    request: Request,
    db: Session = Depends(get_db),
    new_password: str = None,
    confirm_password: str = None,
    mfa_code: str = None,
    step: str = None
):
    """Handle password reset form and process - FULLY FIXED"""
    
    try:
        payload = verify_reset_token(token)
        email = payload.get("sub")
        
        if payload.get("type") != "reset":
            raise HTTPException(status_code=400, detail="Invalid token type")
            
    except jwt.ExpiredSignatureError:
        return HTMLResponse(content="""
        <!DOCTYPE html>
        <html><head><title>Token Expired</title>
        <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
        <body>
            <h2>🕐 Token Expired</h2>
            <p>This password reset link has expired. Please request a new one.</p>
            <a href="/login/forgot-password" style="color:#667eea;">Request New Reset Link</a>
        </body></html>
        """, status_code=400)
    except (jwt.JWTError, jwt.InvalidTokenError):
        return HTMLResponse(content="""
        <!DOCTYPE html>
        <html><head><title>Invalid Token</title>
        <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
        <body>
            <h2>❌ Invalid Token</h2>
            <p>This password reset link is invalid or has been used.</p>
            <a href="/login/forgot-password" style="color:#667eea;">Request New Reset Link</a>
        </body></html>
        """, status_code=400)
    
    # Find user
    user = db.query(m.User).filter(m.User.email == email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if email not in reset_password_tokens:
        return HTMLResponse(content="""
        <!DOCTYPE html>
        <html><head><title>Token Not Found</title>
        <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
        <body>
            <h2>❌ Token Not Found</h2>
            <p>This reset token is not valid or has been used.</p>
            <a href="/login/forgot-password" style="color:#667eea;">Request New Reset Link</a>
        </body></html>
        """, status_code=400)
    
    if not new_password:
        return HTMLResponse(content=f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Reset Password</title>
            <style>
                body {{
                    font-family: Arial, sans-serif;
                    background: #f4f4f4;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    margin: 0;
                }}
                .container {{
                    background: white;
                    padding: 40px;
                    border-radius: 10px;
                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                    max-width: 450px;
                    width: 100%;
                }}
                h2 {{
                    text-align: center;
                    color: #333;
                    margin-bottom: 30px;
                }}
                .user-info {{
                    background: #f8f9fa;
                    padding: 15px;
                    border-radius: 5px;
                    margin-bottom: 20px;
                    text-align: center;
                }}
                input[type="password"] {{
                    width: 100%;
                    padding: 12px;
                    margin: 5px 0 15px 0;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    font-size: 16px;
                    box-sizing: border-box;
                }}
                input.error {{
                    border-color: #dc3545;
                }}
                input.success {{
                    border-color: #28a745;
                }}
                button {{
                    width: 100%;
                    background: #667eea;
                    color: white;
                    padding: 12px;
                    border: none;
                    border-radius: 5px;
                    font-size: 16px;
                    cursor: pointer;
                    margin-top: 10px;
                }}
                button:hover {{
                    background: #5a6fd8;
                }}
                button:disabled {{
                    background: #ccc;
                    cursor: not-allowed;
                }}
                .requirements {{
                    font-size: 13px;
                    color: #666;
                    margin-bottom: 15px;
                    line-height: 1.4;
                }}
                .password-strength {{
                    height: 5px;
                    background: #e9ecef;
                    border-radius: 3px;
                    margin: 5px 0 10px 0;
                }}
                .strength-bar {{
                    height: 100%;
                    border-radius: 3px;
                    transition: all 0.3s ease;
                }}
                .strength-weak {{ background: #dc3545; width: 25%; }}
                .strength-fair {{ background: #ffc107; width: 50%; }}
                .strength-good {{ background: #17a2b8; width: 75%; }}
                .strength-strong {{ background: #28a745; width: 100%; }}
                .error-message {{
                    color: #dc3545;
                    font-size: 14px;
                    margin-top: 5px;
                    display: none;
                }}
                .match-status {{
                    color: #dc3545;
                    font-size: 14px;
                    margin-top: 5px;
                    display: none;
                }}
                .match-success {{
                    color: #28a745;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <h2>🔐 Reset Password</h2>
                <div class="user-info">
                    <strong>Email:</strong> {email}
                </div>
                
                <form id="resetForm" method="get" action="{request.url.path}">
                    <input type="hidden" name="token" value="{token}">
                    <input type="hidden" name="step" value="verify_password">
                    
                    <label>New Password:</label>
                    <input type="password" id="new_password" name="new_password" required minlength="8">
                    <div class="password-strength">
                        <div id="strengthBar" class="strength-bar"></div>
                    </div>
                    <div id="passwordError" class="error-message"></div>
                    
                    <label>Confirm Password:</label>
                    <input type="password" id="confirm_password" name="confirm_password" required minlength="8">
                    <div id="matchStatus" class="match-status"></div>
                    
                    <div class="requirements">
                        Password must contain:
                        <ul style="margin: 5px 0; padding-left: 20px;">
                            <li id="req-length">At least 8 characters</li>
                            <li id="req-upper">One uppercase letter</li>
                            <li id="req-lower">One lowercase letter</li>
                            <li id="req-digit">One number</li>
                            <li id="req-different">Must be different from current password</li>
                        </ul>
                    </div>
                    
                    <button type="submit" id="submitBtn" disabled>Continue</button>
                </form>
            </div>

            <script>
                const newPasswordInput = document.getElementById('new_password');
                const confirmPasswordInput = document.getElementById('confirm_password');
                const submitBtn = document.getElementById('submitBtn');
                const strengthBar = document.getElementById('strengthBar');
                const passwordError = document.getElementById('passwordError');
                const matchStatus = document.getElementById('matchStatus');
                
                let isPasswordValid = false;
                let isMatchValid = false;
                let isDifferentFromCurrent = true; // Will be checked on server
                
                function checkPasswordStrength(password) {{
                    const requirements = {{
                        length: password.length >= 8,
                        upper: /[A-Z]/.test(password),
                        lower: /[a-z]/.test(password),
                        digit: /[0-9]/.test(password)
                    }};
                    
                    // Update requirement indicators
                    document.getElementById('req-length').style.color = requirements.length ? '#28a745' : '#dc3545';
                    document.getElementById('req-upper').style.color = requirements.upper ? '#28a745' : '#dc3545';
                    document.getElementById('req-lower').style.color = requirements.lower ? '#28a745' : '#dc3545';
                    document.getElementById('req-digit').style.color = requirements.digit ? '#28a745' : '#dc3545';
                    
                    const score = Object.values(requirements).filter(Boolean).length;
                    
                    // Update strength bar
                    strengthBar.className = 'strength-bar';
                    if (score === 4) {{
                        strengthBar.classList.add('strength-strong');
                    }} else if (score === 3) {{
                        strengthBar.classList.add('strength-good');
                    }} else if (score === 2) {{
                        strengthBar.classList.add('strength-fair');
                    }} else if (score >= 1) {{
                        strengthBar.classList.add('strength-weak');
                    }}
                    
                    isPasswordValid = score === 4;
                    
                    // Show error if password is not valid
                    if (password.length > 0 && !isPasswordValid) {{
                        passwordError.textContent = 'Password must meet all requirements above';
                        passwordError.style.display = 'block';
                        newPasswordInput.className = 'error';
                    }} else if (password.length > 0 && isPasswordValid) {{
                        passwordError.style.display = 'none';
                        newPasswordInput.className = 'success';
                    }} else {{
                        passwordError.style.display = 'none';
                        newPasswordInput.className = '';
                    }}
                    
                    updateSubmitButton();
                }}
                
                function checkPasswordMatch() {{
                    const newPassword = newPasswordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    
                    if (confirmPassword.length > 0) {{
                        if (newPassword === confirmPassword) {{
                            matchStatus.textContent = '✓ Passwords match';
                            matchStatus.className = 'match-status match-success';
                            matchStatus.style.display = 'block';
                            confirmPasswordInput.className = 'success';
                            isMatchValid = true;
                        }} else {{
                            matchStatus.textContent = '✗ Passwords do not match';
                            matchStatus.className = 'match-status';
                            matchStatus.style.display = 'block';
                            confirmPasswordInput.className = 'error';
                            isMatchValid = false;
                        }}
                    }} else {{
                        matchStatus.style.display = 'none';
                        confirmPasswordInput.className = '';
                        isMatchValid = false;
                    }}
                    
                    updateSubmitButton();
                }}
                
                function updateSubmitButton() {{
                    if (isPasswordValid && isMatchValid && isDifferentFromCurrent) {{
                        submitBtn.disabled = false;
                        submitBtn.style.background = '#667eea';
                    }} else {{
                        submitBtn.disabled = true;
                        submitBtn.style.background = '#ccc';
                    }}
                }}
                
                newPasswordInput.addEventListener('input', function() {{
                    checkPasswordStrength(this.value);
                    if (confirmPasswordInput.value) {{
                        checkPasswordMatch();
                    }}
                }});
                
                confirmPasswordInput.addEventListener('input', checkPasswordMatch);
                
                // Form submission with additional validation
                document.getElementById('resetForm').addEventListener('submit', function(e) {{
                    if (!isPasswordValid) {{
                        e.preventDefault();
                        alert('Please ensure your password meets all requirements');
                        return;
                    }}
                    
                    if (!isMatchValid) {{
                        e.preventDefault();
                        alert('Passwords do not match');
                        return;
                    }}
                    
                    submitBtn.disabled = true;
                    submitBtn.textContent = 'Processing...';
                }});
            </script>
        </body>
        </html>
        """, status_code=200)
    
    if step == "verify_password":
        
        if new_password != confirm_password:
            return HTMLResponse(content="""
            <!DOCTYPE html>
            <html><head><title>Password Mismatch</title>
            <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
            <body>
                <h2>❌ Passwords Don't Match</h2>
                <p>The passwords you entered don't match. Please try again.</p>
                <button onclick="history.back()">Go Back</button>
            </body></html>
            """, status_code=400)
        
        is_valid, error_message = validate_password_strength(new_password, email)
        if not is_valid:
            return HTMLResponse(content=f"""
            <!DOCTYPE html>
            <html><head><title>Invalid Password</title>
            <style>body{{font-family:Arial;text-align:center;padding:50px;}}</style></head>
            <body>
                <h2>❌ Invalid Password</h2>
                <p>{error_message}</p>
                <button onclick="history.back()">Go Back</button>
            </body></html>
            """, status_code=400)
        
        if not check_password_history(user, new_password):
            return HTMLResponse(content="""
            <!DOCTYPE html>
            <html><head><title>Same Password</title>
            <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
            <body>
                <h2>❌ Password Cannot Be The Same</h2>
                <p>Your new password cannot be the same as your current password. Please choose a different password.</p>
                <button onclick="history.back()">Go Back</button>
            </body></html>
            """, status_code=400)
        
        if (user.failed_login_count > 0 or user.requires_mfa_setup) and not user.mfa_enabled:
            return HTMLResponse(content=f"""
            <!DOCTYPE html>
            <html>
            <head>
                <title>MFA Setup Required</title>
                <style>
                    body {{
                        font-family: Arial, sans-serif;
                        background: #f4f4f4;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        min-height: 100vh;
                        margin: 0;
                    }}
                    .container {{
                        background: white;
                        padding: 40px;
                        border-radius: 10px;
                        box-shadow: 0 0 20px rgba(0,0,0,0.1);
                        max-width: 500px;
                        width: 100%;
                        text-align: center;
                    }}
                    .warning-icon {{
                        font-size: 60px;
                        color: #f39c12;
                        margin-bottom: 20px;
                    }}
                    .info-box {{
                        background: #fff3cd;
                        border: 1px solid #ffeaa7;
                        padding: 20px;
                        border-radius: 8px;
                        margin: 20px 0;
                        text-align: left;
                    }}
                    button {{
                        background: #667eea;
                        color: white;
                        padding: 15px 30px;
                        border: none;
                        border-radius: 5px;
                        font-size: 16px;
                        cursor: pointer;
                        margin: 10px;
                    }}
                    button:hover {{
                        background: #5a6fd8;
                    }}
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="warning-icon">⚠️</div>
                    <h2>MFA Setup Required</h2>
                    
                    <div class="info-box">
                        <h4>🔒 Enhanced Security Required</h4>
                        <p>Before you can reset your password, you need to set up Multi-Factor Authentication (MFA) for enhanced security.</p>
                        <p><strong>Why is this required?</strong></p>
                        <ul>
                            <li>MFA provides an additional layer of security</li>
                            <li>This helps protect your account from unauthorized access</li>
                        </ul>
                    </div>
                    
                    <p><strong>Next Steps:</strong></p>
                    <p>1. Set up MFA using Google Authenticator</p>
                    <p>2. Complete password reset with MFA verification</p>
                    
                    <form method="get" action="{request.url.path}">
                        <input type="hidden" name="token" value="{token}">
                        <input type="hidden" name="new_password" value="{new_password}">
                        <input type="hidden" name="confirm_password" value="{confirm_password}">
                        <input type="hidden" name="step" value="setup_mfa">
                        <button type="submit">Setup MFA Now</button>
                    </form>
                </div>
            </body>
            </html>
            """, status_code=200)
        
        elif user.mfa_enabled and user.mfa_secret:
            return HTMLResponse(content=f"""
            <!DOCTYPE html>
            <html>
            <head>
                <title>MFA Verification</title>
                <style>
                    body {{
                        font-family: Arial, sans-serif;
                        background: #f4f4f4;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        min-height: 100vh;
                        margin: 0;
                    }}
                    .container {{
                        background: white;
                        padding: 40px;
                        border-radius: 10px;
                        box-shadow: 0 0 20px rgba(0,0,0,0.1);
                        max-width: 400px;
                        width: 100%;
                        text-align: center;
                    }}
                    input[type="text"] {{
                        width: 200px;
                        padding: 15px;
                        font-size: 24px;
                        text-align: center;
                        border: 2px solid #ddd;
                        border-radius: 5px;
                        margin: 20px 0;
                        letter-spacing: 5px;
                    }}
                    button {{
                        width: 100%;
                        background: #667eea;
                        color: white;
                        padding: 15px;
                        border: none;
                        border-radius: 5px;
                        font-size: 16px;
                        cursor: pointer;
                    }}
                    .info-box {{
                        background: #e3f2fd;
                        border: 1px solid #90caf9;
                        padding: 15px;
                        border-radius: 5px;
                        margin-bottom: 20px;
                    }}
                </style>
            </head>
            <body>
                <div class="container">
                    <h2>🔐 MFA Verification Required</h2>
                    
                    <div class="info-box">
                        <p>Enter your 6-digit Google Authenticator code to complete the password reset.</p>
                    </div>
                    
                    <form method="get" action="{request.url.path}">
                        <input type="hidden" name="token" value="{token}">
                        <input type="hidden" name="new_password" value="{new_password}">
                        <input type="hidden" name="confirm_password" value="{confirm_password}">
                        <input type="hidden" name="step" value="complete_reset">
                        
                        <input type="text" name="mfa_code" placeholder="000000" maxlength="6" required 
                               pattern="[0-9]{{6}}" title="Please enter a 6-digit code">
                        <br>
                        <button type="submit">Complete Password Reset</button>
                    </form>
                </div>
            </body>
            </html>
            """, status_code=200)
        else:
            step = "complete_reset"
    
    if step == "setup_mfa":
        
        if not user.mfa_secret:
            from app.utils.security import generate_mfa_secret
            user.mfa_secret = generate_mfa_secret()
            db.commit()
        
        from app.utils.security import generate_qr_code
        qr_code_data_uri = generate_qr_code(user.email, user.mfa_secret, "Attendance System")
        
        return HTMLResponse(content=f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Setup MFA</title>
            <style>
                body {{
                    font-family: Arial, sans-serif;
                    background: #f4f4f4;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    margin: 0;
                }}
                .container {{
                    background: white;
                    padding: 40px;
                    border-radius: 10px;
                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                    max-width: 500px;
                    width: 100%;
                    text-align: center;
                }}
                .qr-code {{
                    margin: 20px 0;
                    padding: 20px;
                    border: 2px dashed #ddd;
                    border-radius: 10px;
                }}
                .manual-entry {{
                    background: #f8f9fa;
                    padding: 15px;
                    border-radius: 5px;
                    margin: 20px 0;
                    font-family: monospace;
                    word-break: break-all;
                }}
                input[type="text"] {{
                    width: 200px;
                    padding: 15px;
                    font-size: 24px;
                    text-align: center;
                    border: 2px solid #ddd;
                    border-radius: 5px;
                    margin: 20px 0;
                    letter-spacing: 5px;
                }}
                button {{
                    width: 100%;
                    background: #667eea;
                    color: white;
                    padding: 15px;
                    border: none;
                    border-radius: 5px;
                    font-size: 16px;
                    cursor: pointer;
                }}
                .steps {{
                    text-align: left;
                    margin: 20px 0;
                }}
                .steps li {{
                    margin: 10px 0;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <h2>🔐 Setup Multi-Factor Authentication</h2>
                
                <div class="steps">
                    <h4>Follow these steps:</h4>
                    <ol>
                        <li>Install <strong>Google Authenticator</strong> on your phone</li>
                        <li>Scan the QR code below OR enter the manual key</li>
                        <li>Enter the 6-digit code from the app</li>
                    </ol>
                </div>
                
                <div class="qr-code">
                    <img src="{qr_code_data_uri}" alt="QR Code" style="max-width: 200px;">
                </div>
                
                <div class="manual-entry">
                    <strong>Manual Entry Key:</strong><br>
                    {user.mfa_secret}
                </div>
                
                <form method="get" action="{request.url.path}">
                    <input type="hidden" name="token" value="{token}">
                    <input type="hidden" name="new_password" value="{new_password}">
                    <input type="hidden" name="confirm_password" value="{confirm_password}">
                    <input type="hidden" name="step" value="verify_mfa_setup">
                    
                    <input type="text" name="mfa_code" placeholder="000000" maxlength="6" required 
                           pattern="[0-9]{{6}}" title="Please enter a 6-digit code">
                    <br>
                    <button type="submit">Verify & Complete Setup</button>
                </form>
            </div>
        </body>
        </html>
        """, status_code=200)
    
    if step == "verify_mfa_setup":
        
        if not mfa_code:
            raise HTTPException(status_code=400, detail="MFA code required")
    
        from app.utils.security import verify_mfa_token
        
        if not verify_mfa_token(user.mfa_secret, mfa_code):
            return HTMLResponse(content="""
            <!DOCTYPE html>
            <html><head><title>Invalid MFA Code</title>
            <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
            <body>
                <h2>❌ Invalid MFA Code</h2>
                <p>The Google Authenticator code is invalid or expired. Please try again.</p>
                <button onclick="history.back()">Try Again</button>
            </body></html>
            """, status_code=400)
        
        user.mfa_enabled = True
        user.requires_mfa_setup = False
        db.commit()
        
        # Now proceed to complete password reset
        step = "complete_reset"
    
    if step == "complete_reset":
        
    
        if user.mfa_enabled and user.mfa_secret:
            if not mfa_code:
                raise HTTPException(status_code=400, detail="MFA code required")
            
            from app.utils.security import verify_mfa_token
            
            if not verify_mfa_token(user.mfa_secret, mfa_code):
                return HTMLResponse(content="""
                <!DOCTYPE html>
                <html><head><title>Invalid MFA Code</title>
                <style>body{font-family:Arial;text-align:center;padding:50px;}</style></head>
                <body>
                    <h2>❌ Invalid MFA Code</h2>
                    <p>The Google Authenticator code is invalid or expired.</p>
                    <button onclick="history.back()">Try Again</button>
                </body></html>
                """, status_code=400)
        
        is_valid, error_message = validate_password_strength(new_password, email)
        if not is_valid:
            raise HTTPException(status_code=400, detail=error_message)
        

        if not check_password_history(user, new_password):
            raise HTTPException(status_code=400, detail="New password cannot be the same as current password")
        
        try:
            hashed_password = hash_password(new_password)
            
            # Update user password and reset security flags
            user.password = hashed_password
            user.failed_login_count = 0
            user.requires_mfa_setup = False
            
            # Reset login attempts
            latest_attempt = (
                db.query(m.LoginAttempt)
                .filter(m.LoginAttempt.email == email)
                .order_by(m.LoginAttempt.attempt_time.desc())
                .first()
            )
            
            if latest_attempt:
                latest_attempt.failed_attempts = 0
                latest_attempt.lockout_until = None
            
            # ✅ FIXED: Remove from permanent lock and reset tokens
            if email in permanent_lock_tokens:
                del permanent_lock_tokens[email]
                
            if email in reset_password_tokens:
                del reset_password_tokens[email]
            
            db.commit()
            
            # Log activity
            create_activity_log(
                db=db,
                request=request,
                user_id=user.user_id,
                action="Password Reset Completed",
                detail=f"User {user.email} successfully reset password" + 
                       (" with MFA verification" if user.mfa_enabled else "") +
                       (" and enabled MFA" if not user.mfa_enabled else "")
            )
            
            # Success page
            return HTMLResponse(content=f"""
            <!DOCTYPE html>
            <html>
            <head>
                <title>Password Reset Successful</title>
                <style>
                    body {{
                        font-family: Arial, sans-serif;
                        background: #f4f4f4;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        min-height: 100vh;
                        margin: 0;
                    }}
                    .container {{
                        background: white;
                        padding: 50px;
                        border-radius: 10px;
                        box-shadow: 0 0 20px rgba(0,0,0,0.1);
                        max-width: 600px;
                        width: 100%;
                        text-align: center;
                    }}
                    .success-icon {{
                        font-size: 60px;
                        color: #27ae60;
                        margin-bottom: 20px;
                    }}
                    h1 {{
                        color: #2c3e50;
                        margin-bottom: 15px;
                    }}
                    p {{
                        color: #7f8c8d;
                        line-height: 1.6;
                        margin-bottom: 30px;
                    }}
                    .info-box {{
                        background: #e8f5e8;
                        border: 1px solid #4caf50;
                        padding: 20px;
                        border-radius: 8px;
                        margin: 20px 0;
                        text-align: left;
                    }}
                    .login-btn {{
                        background: #667eea;
                        color: white;
                        padding: 15px 40px;
                        text-decoration: none;
                        border-radius: 5px;
                        font-size: 16px;
                        font-weight: bold;
                        display: inline-block;
                    }}
                    .login-btn:hover {{
                        background: #5a6fd8;
                    }}
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="success-icon">✅</div>
                    <h1>Password Reset Successful!</h1>
                    
                    <p>
                        Your password has been successfully reset and your account security has been enhanced.
                        You can now log in with your new credentials.
                    </p>
                </div>
            </body>
            </html>
            """, status_code=200)
            
        except Exception as e:
            raise HTTPException(status_code=500, detail="Failed to update password")

def get_improved_forgot_password_frontend():
    """Returns improved frontend JavaScript code for forgot password functionality"""
    return """
// ✅ IMPROVED FORGOT PASSWORD MODAL WITH REAL-TIME VALIDATION
document.addEventListener('DOMContentLoaded', function() {
    
    // Modal functions
    window.openForgotPasswordModal = function() {
        const modal = document.getElementById('forgotPasswordModal');
        if (modal) {
            modal.style.display = 'block';
            const emailInput = document.getElementById('resetEmail');
            if (emailInput) {
                setTimeout(() => emailInput.focus(), 100);
            }
        }
    }
    
    window.closeForgotPasswordModal = function() {
        const modal = document.getElementById('forgotPasswordModal');
        if (modal) {
            modal.style.display = 'none';
            const form = document.getElementById('forgotPasswordForm');
            const messageDiv = document.getElementById('resetMessage');
            if (form) form.reset();
            if (messageDiv) messageDiv.innerHTML = '';
        }
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('forgotPasswordModal');
        if (event.target == modal) {
            closeForgotPasswordModal();
        }
    }
    
    // ✅ ENHANCED: Handle forgot password form submission with better error handling
    const forgotForm = document.getElementById('forgotPasswordForm');
    if (forgotForm) {
        const emailInput = document.getElementById('resetEmail');
        const submitBtn = forgotForm.querySelector('button[type="submit"]');
        const messageDiv = document.getElementById('resetMessage');
        
        // Real-time email validation
        emailInput.addEventListener('input', function() {
            const email = this.value.trim();
            const emailRegex = /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/;
            
            if (email && !emailRegex.test(email)) {
                this.style.borderColor = '#dc3545';
                submitBtn.disabled = true;
                showMessage('Please enter a valid email address', 'error');
            } else if (email && emailRegex.test(email)) {
                this.style.borderColor = '#28a745';
                submitBtn.disabled = false;
                hideMessage();
            } else {
                this.style.borderColor = '#ddd';
                submitBtn.disabled = false;
                hideMessage();
            }
        });
        
        forgotForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const email = formData.get('email').trim();
            const originalText = submitBtn.textContent;
            
            // Validate email
            if (!email) {
                showMessage('Please enter your email address', 'error');
                return;
            }
            
            const emailRegex = /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/;
            if (!emailRegex.test(email)) {
                showMessage('Please enter a valid email address', 'error');
                return;
            }
            
            // Clear previous messages
            hideMessage();
            
            try {
                
                // Show loading state
                submitBtn.textContent = 'Sending...';
                submitBtn.disabled = true;
                
                // ✅ FIXED: Real API call with proper error handling
                const response = await fetch('http://localhost:8000/login/forgot-password', {
                    method: 'POST',
                    body: formData
                });
                
                let result;
                try {
                    result = await response.json();
                } catch (jsonError) {
                    result = { detail: 'Server response error' };
                }
                
                if (response.ok) {
                    // ✅ Success - Email sent
                    showMessage(
                        result.message || 'Password reset link has been sent to your email. Please check your inbox.',
                        'success'
                    );
                    
                    // Clear form
                    emailInput.value = '';
                    emailInput.style.borderColor = '#ddd';
                    
                    // Auto close modal after 3 seconds
                    setTimeout(() => {
                        closeForgotPasswordModal();
                    }, 3000);
                    
                } else {
                    // ❌ Error response
                    
                    let errorMessage = 'An error occurred. Please try again.';
                    
                    if (response.status === 404) {
                        errorMessage = 'Email address not found in our system.';
                    } else if (response.status === 429) {
                        errorMessage = 'Too many requests. Please wait before trying again.';
                    } else if (response.status >= 500) {
                        errorMessage = 'Server error. Please try again later.';
                    } else if (result.detail) {
                        errorMessage = result.detail;
                    }
                    
                    showMessage(errorMessage, 'error');
                }
                
            } catch (error) {
                
                let errorMessage = 'Network error. Please check your connection and try again.';
                if (error.name === 'TypeError' && error.message.includes('fetch')) {
                    errorMessage = 'Cannot connect to server. Please check if the server is running.';
                }
                
                showMessage(errorMessage, 'error');
            } finally {
                // Reset button state
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            }
        });
        
        function showMessage(message, type) {
            messageDiv.innerHTML = `
                <div class="${type}-message" style="
                    color: ${type === 'success' ? '#155724' : '#721c24'};
                    background-color: ${type === 'success' ? '#d4edda' : '#f8d7da'};
                    border: 1px solid ${type === 'success' ? '#c3e6cb' : '#f5c6cb'};
                    padding: 12px;
                    border-radius: 5px;
                    margin-top: 10px;
                    font-size: 14px;
                    line-height: 1.4;
                ">
                    ${type === 'success' ? '✅' : '❌'} ${message}
                </div>
            `;
        }
        
        function hideMessage() {
            messageDiv.innerHTML = '';
        }
    }
    
    // Handle login form (existing functionality)
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            // Add your existing login logic here
        });
    }
});
"""

# ===== FORGOT PASSWORD FORM PAGE =====
@router.get("/forgot-password")
async def forgot_password_form():
    """Display forgot password form"""
    return HTMLResponse(content="""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }
            .container {
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                max-width: 400px;
                width: 100%;
            }
            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }
            input[type="email"] {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                box-sizing: border-box;
            }
            button {
                width: 100%;
                background: #667eea;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                margin-top: 10px;
            }
            button:hover {
                background: #5a6fd8;
            }
            .back-link {
                text-align: center;
                margin-top: 20px;
            }
            .back-link a {
                color: #667eea;
                text-decoration: none;
            }
            .status-message {
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                display: none;
            }
            .status-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .status-error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>🔐 Forgot Password</h2>
            <p>Enter your email address and we'll send you a link to reset your password.</p>
            
            <div id="statusMessage" class="status-message"></div>
            
            <form id="forgotForm" method="post" action="/login/forgot-password">
                <label>Email Address:</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
                <button type="submit" id="submitBtn">Send Reset Link</button>
            </form>
            
            <div class="back-link">
                <a href="/login">← Back to Login</a>
            </div>
        </div>

        <script>
            const form = document.getElementById('forgotForm');
            const submitBtn = document.getElementById('submitBtn');
            const statusMessage = document.getElementById('statusMessage');
            
            form.addEventListener('submit', async function(e) {
                e.preventDefault();
                
                const email = document.getElementById('email').value;
                if (!email) {
                    showMessage('Please enter your email address', 'error');
                    return;
                }
                
                submitBtn.disabled = true;
                submitBtn.textContent = 'Sending...';
                hideMessage();
                
                try {
                    const formData = new FormData();
                    formData.append('email', email);
                    
                    const response = await fetch('/login/forgot-password', {
                        method: 'POST',
                        body: formData
                    });
                    
                    const result = await response.json();
                    
                    if (response.ok) {
                        showMessage('Reset link sent! Check your email inbox.', 'success');
                        form.reset();
                    } else {
                        showMessage(result.detail || 'Failed to send reset link.', 'error');
                    }
                } catch (error) {
                    showMessage('Network error. Please try again.', 'error');
                } finally {
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Send Reset Link';
                }
            });
            
            function showMessage(message, type) {
                statusMessage.textContent = message;
                statusMessage.className = `status-message status-${type}`;
                statusMessage.style.display = 'block';
            }
            
            function hideMessage() {
                statusMessage.style.display = 'none';
            }
        </script>
    </body>
    </html>
    """, status_code=200)