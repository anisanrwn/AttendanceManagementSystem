from fastapi import APIRouter, Depends, HTTPException, Form
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m
from app.routes.mfa_utils import decrypt_secret
import pyotp

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/login")
def login(email: str = Form(...), password: str = Form(...), mfa_token: str = Form(None), db: Session = Depends(get_db)):
    user = db.query(m.User).filter(m.User.email == email).first()

    if not user or user.password != password:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if user.mfa_secret:
        if not mfa_token:
            raise HTTPException(status_code=401, detail="MFA token required")

        secret = decrypt_secret(user.mfa_secret)
        totp = pyotp.TOTP(secret)

        if not totp.verify(mfa_token):
            raise HTTPException(status_code=400, detail="Invalid MFA token")

    return {"message": "Login successful"}