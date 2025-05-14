from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer  # <-- Tambahkan ini
from jose import jwt
from sqlalchemy.orm import Session
from app.database import get_db
from app.models import model as m

SECRET_KEY = "secret_key_anda"
ALGORITHM = "HS256"

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")  # <-- Perhatikan tokenUrl harus sesuai endpoint login

def verify_token(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token expired",
            headers={"WWW-Authenticate": "Bearer"},
        )
    except jwt.JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
            headers={"WWW-Authenticate": "Bearer"},
        )

def get_current_user(db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    payload = verify_token(token)
    user = db.query(m.User).filter(m.User.user_id == payload['user_id']).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user