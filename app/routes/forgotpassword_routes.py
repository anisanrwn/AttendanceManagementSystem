from fastapi import APIRouter, Form, HTTPException, Depends, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
import jwt
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

router = APIRouter()

# Konfigurasi (sesuaikan dengan config Anda)
SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"
EMAIL_ADDRESS = "hrsystem812@gmail.com"  
EMAIL_PASSWORD = "dfxhwuyiwqszauxh"   
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587

# Dictionary untuk menyimpan reset tokens (gunakan Redis di production)
reset_password_tokens = {}

@router.post("/forgot-password")
async def forgot_password(
    email: str = Form(...),
    db: Session = Depends(get_db)  # Sesuaikan dengan dependency Anda
):
    """Initiate password reset process"""
    # Import model User sesuai dengan struktur Anda
    from . import models as m  # Sesuaikan import
    
    user = db.query(m.User).filter_by(email=email).first()
    
    if not user:
        # Untuk keamanan, selalu return success meski user tidak ditemukan
        return {
            "status": "success",
            "message": "If the email exists in our system, a password reset link will be sent."
        }
    
    # Generate reset token
    reset_token = create_reset_token(email)
    reset_password_tokens[email] = reset_token
    
    # Create reset link
    reset_link = f"http://localhost:8000/reset-password?token={reset_token}"
    
    # Send reset email
    if send_reset_password_email(user.email, reset_link):
        return {
            "status": "success", 
            "message": "Password reset link has been sent to your email."
        }
    else:
        raise HTTPException(status_code=500, detail="Failed to send reset email")

def create_reset_token(email: str):
    """Create password reset token"""
    expire = datetime.utcnow() + timedelta(minutes=30)  # 30 minutes expiry
    payload = {
        "sub": email,
        "type": "reset",
        "exp": expire
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def send_reset_password_email(to_email: str, reset_link: str):
    """Send password reset email"""
    try:
        email_message = MIMEMultipart()
        email_message["From"] = EMAIL_ADDRESS
        email_message["To"] = to_email
        email_message["Subject"] = "Password Reset Request - Attendance System"

        email_body = f"""
        <html>
        <body style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <h2>Password Reset Request</h2>
            <p>You requested a password reset for your account: <strong>{to_email}</strong></p>
            <p>Click the button below to reset your password:</p>
            <div style="text-align: center; margin: 30px 0;">
                <a href="{reset_link}" 
                   style="background: #667eea; color: white; padding: 15px 30px; 
                          text-decoration: none; border-radius: 8px; font-weight: bold;">
                    Reset Password
                </a>
            </div>
            <p>This link will expire in 30 minutes.</p>
            <p>If you didn't request this, please ignore this email.</p>
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
        print(f"Failed to send password reset email: {e}")
        return False