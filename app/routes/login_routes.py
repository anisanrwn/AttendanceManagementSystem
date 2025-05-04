from fastapi import APIRouter, Depends, HTTPException, Form, Request, status
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from datetime import datetime, timedelta
from app.utils.verifpass import verify_password

router = APIRouter(
    prefix="/login",
    tags=["Login"]
)

# Brute force protection settings
MAX_USER_ATTEMPTS = 5
MAX_IP_ATTEMPTS = 10
LOCKOUT_TIME = timedelta(minutes=5)
IP_BAN_TIME = timedelta(minutes=30)

async def get_client_ip(request: Request) -> str:
    if "x-forwarded-for" in request.headers:
        return request.headers["x-forwarded-for"].split(",")[0]
    return request.client.host if request.client else "unknown"

def check_attempts(db: Session, email: str, ip_address: str):
    now = datetime.now()

    # IP Lock Check
    recent_ip_attempt = db.query(m.LoginAttempt).filter(
        m.LoginAttempt.ip_address == ip_address,
        m.LoginAttempt.is_successful == False,
        m.LoginAttempt.attempt_time >= now - IP_BAN_TIME
    ).order_by(m.LoginAttempt.attempt_time.desc()).first()

    ip_fail_count = db.query(m.LoginAttempt).filter(
        m.LoginAttempt.ip_address == ip_address,
        m.LoginAttempt.is_successful == False,
        m.LoginAttempt.attempt_time >= now - IP_BAN_TIME
    ).count()

    if recent_ip_attempt and ip_fail_count >= MAX_IP_ATTEMPTS:
        block_time_left = (recent_ip_attempt.attempt_time + IP_BAN_TIME) - now
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Your IP is temporarily blocked. Try again in {max(1, block_time_left.seconds // 60)} minutes."
        )

    # User Lock Check
    user = db.query(m.User).filter_by(email=email).first()
    if user:
        recent_user_attempt = db.query(m.LoginAttempt).filter(
            m.LoginAttempt.user_id == user.id,
            m.LoginAttempt.is_successful == False,
            m.LoginAttempt.attempt_time >= now - LOCKOUT_TIME
        ).order_by(m.LoginAttempt.attempt_time.desc()).first()

        user_fail_count = db.query(m.LoginAttempt).filter(
            m.LoginAttempt.user_id == user.id,
            m.LoginAttempt.is_successful == False,
            m.LoginAttempt.attempt_time >= now - LOCKOUT_TIME
        ).count()

        if recent_user_attempt and user_fail_count >= MAX_USER_ATTEMPTS:
            lock_time_left = (recent_user_attempt.attempt_time + LOCKOUT_TIME) - now
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail=f"Too many failed login attempts. Try again in {max(1, lock_time_left.seconds // 60)} minutes."
            )

@router.post("")
async def login_user(
    request: Request,
    email: str = Form(...),
    password: str = Form(...),
    db: Session = Depends(get_db)
):
    ip_address = await get_client_ip(request)

    # Check for lockouts
    check_attempts(db, email, ip_address)

    user = db.query(m.User).options(joinedload(m.User.login_attempts)).filter_by(email=email).first()

    login_attempt = m.LoginAttempt(
        email=email,
        ip_address=ip_address,
        attempt_time=datetime.now(),
        is_successful=False,
        user_agent=request.headers.get("user-agent", ""),
        user_id=user.id if user else None
    )
    db.add(login_attempt)

    if not user or not verify_password(password, user.password):
        db.commit()
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password"
        )

    login_attempt.is_successful = True
    db.commit()

    return {
        "message": "Login successful",
        "user_id": user.id,
        "email": user.email
    }
