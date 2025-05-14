from fastapi import APIRouter, Depends, HTTPException, Form, Request, status, Response, Body
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import func
from app.database import get_db
from app.models import model as m
from datetime import datetime, timedelta
from app.schemas import schemas as s
from app.utils.verifpass import verify_password
from user_agents import parse
import json
import asyncio
from app.utils.auth import verify_token, get_current_user, create_access_token, create_refresh_token
from fastapi.responses import StreamingResponse
from fastapi.templating import Jinja2Templates
from jose import jwt

# JWT Configuration
SECRET_KEY = "your-secret-key-here"  # Ganti dengan key yang aman
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

router = APIRouter(
    prefix="/login",
    tags=["Login"]
)
templates = Jinja2Templates(directory="templates")

@router.get("/login")
async def login_page(request: Request):
    return templates.TemplateResponse("login.html", {"request": request})

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
            detail="Notification not found or you don't have permission"
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
            raise HTTPException(status_code=401, detail="Invalid token type")
            
        user_id = payload.get("sub")
        user = db.query(m.User).filter(m.User.user_id == user_id).first()
        
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
            
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
        raise HTTPException(status_code=401, detail="Refresh token expired")
    except jwt.JWTError:
        raise HTTPException(status_code=401, detail="Invalid refresh token")

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
            raise HTTPException(
                status_code=403,
                detail=f"Akun dikunci. Silakan coba lagi setelah {attempt.lockout_until.strftime('%H:%M:%S')} UTC"
            )
        if attempt.failed_attempts >= 10:
            raise HTTPException(
                status_code=403,
                detail="IP Anda telah diblokir karena terlalu banyak percobaan login yang gagal."
            )

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
                notification = m.Notification(
                    user_id=user.user_id,
                    title="Percobaan Login Gagal",
                    message="Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.",
                    notification_type="failed_login"
                )
                db.add(notification)

        if attempt.failed_attempts >= 10:
            attempt.lockout_until = now + timedelta(hours=1)

        db.commit()
        raise HTTPException(status_code=401, detail="Email atau password salah.")

    # Generate tokens
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
                title="Login dari Perangkat Baru",
                message=f"Login terdeteksi dari IP: {ip_address}, Perangkat: {browser_name}",
                notification_type="new_device"
            )
            db.add(notification)

    db.commit()
    
    user_dict = {
        "user_id": user.user_id,
        "email": user.email,
        "employee_id": user.employee_id,
        "roles": [{"roles_name": role.roles_name} for role in user.roles],
        "access_token": access_token,
        "refresh_token": refresh_token
    }
    
    return user_dict
