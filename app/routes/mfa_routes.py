from fastapi import APIRouter, Depends, HTTPException, Form
from sqlalchemy.orm import Session
import pyotp
from app.database import get_db
from app.models import model as m  # Import model dengan alias m
from .mfa_utils import encrypt_secret, decrypt_secret

router = APIRouter(prefix="/mfa", tags=["MFA"])

@router.post("/enable")
def enable_mfa(user_id: int, db: Session = Depends(get_db)):
    user = db.query(m.User).filter(m.User.user_id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    secret = pyotp.random_base32()
    encrypted_secret = encrypt_secret(secret)

    user.mfa_secret = encrypted_secret
    db.commit()

    uri = pyotp.totp.TOTP(secret).provisioning_uri(
        name=user.email, issuer_name="MyApp"
    )

    return {"otpauth_uri": uri, "secret": secret}

@router.post("/verify")
def verify_mfa(user_id: int, token: str = Form(...), db: Session = Depends(get_db)):
    user = db.query(m.User).filter(m.User.user_id == user_id).first()
    if not user or not user.mfa_secret:
        raise HTTPException(status_code=404, detail="MFA not enabled")

    secret = decrypt_secret(user.mfa_secret)
    totp = pyotp.TOTP(secret)

    if not totp.verify(token):
        raise HTTPException(status_code=400, detail="Invalid MFA token")

    return {"message": "MFA verified successfully"}




