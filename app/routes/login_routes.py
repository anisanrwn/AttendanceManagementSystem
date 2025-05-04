from fastapi import APIRouter, Depends, HTTPException, Form, Request, status
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import func
from app.database import get_db
from app.models import model as m
from datetime import datetime, timedelta
from app.schemas import schemas as s
from app.utils.verifpass import verify_password

router = APIRouter(
    prefix="/login",
    tags=["Login"]
)

@router.post("/login", response_model=s.UserRead)
async def login_user(
    request: Request,
    email: str = Form(...),
    password: str = Form(...),
    db: Session = Depends(get_db)
):
    ip_address = request.client.host
    user_agent = request.headers.get("user-agent")

    # Cek apakah user ada
    user = db.query(m.User).options(joinedload(m.User.roles)).filter_by(email=email).first()

    # Ambil login attempt terakhir berdasarkan email dan IP
    attempt = (
        db.query(m.LoginAttempt)
        .filter_by(email=email, ip_address=ip_address)
        .order_by(m.LoginAttempt.attempt_time.desc())
        .first()
    )

    now = datetime.utcnow()

    if attempt:
        # Jika sudah di-lock dan masih dalam masa lock
        if attempt.lockout_until and now < attempt.lockout_until:
            raise HTTPException(
                status_code=403,
                detail=f"Akun dikunci. Silakan coba lagi setelah {attempt.lockout_until.strftime('%H:%M:%S')} UTC"
            )

        # Jika sudah lebih dari 10x gagal
        if attempt.failed_attempts >= 10:
            raise HTTPException(
                status_code=403,
                detail="IP Anda telah diblokir karena terlalu banyak percobaan login yang gagal."
            )

    # Verifikasi password
    if not user or not verify_password(password, user.password):
        # Update atau buat LoginAttempt baru
        if attempt and (now - attempt.attempt_time) < timedelta(minutes=30):
            # Tambah jumlah percobaan gagal
            attempt.failed_attempts += 1
        else:
            # Reset percobaan karena sudah lewat 30 menit
            attempt = m.LoginAttempt(
                user_id=user.user_id if user else None,
                email=email,
                ip_address=ip_address,
                user_agent=user_agent,
                failed_attempts=1
            )
            db.add(attempt)

        # Atur lockout jika 5x gagal
        if attempt.failed_attempts == 5:
            attempt.lockout_until = now + timedelta(minutes=5)
        elif attempt.failed_attempts >= 10:
            attempt.lockout_until = now + timedelta(hours=1)

        db.commit()
        raise HTTPException(status_code=401, detail="Email atau password salah.")
    

    # Jika login berhasil
    new_attempt = m.LoginAttempt(
        user_id=user.user_id,
        email=email,
        ip_address=ip_address,
        is_successful=True,
        user_agent=user_agent,
        failed_attempts=0
    )
    db.add(new_attempt)
    db.commit()

    return user
