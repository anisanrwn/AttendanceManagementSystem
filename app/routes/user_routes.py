from fastapi import APIRouter, Depends, HTTPException, Form, Path, status
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from typing import List, Optional
from Crypto.Cipher import AES, ChaCha20
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad, unpad
import base64
import os
import logging
from pydantic import BaseModel

# Logging config
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

router = APIRouter(
    prefix="/user",
    tags=["User"]
)

# Encryption keys
AES_KEY_SIZE = 32
CHACHA_KEY_SIZE = 32

SECRET_KEY = os.getenv('SECRET_KEY', 'default-secret-key-32-chars-long!')
AES_KEY = SECRET_KEY[:AES_KEY_SIZE].encode()
CHACHA_KEY = SECRET_KEY[-CHACHA_KEY_SIZE:].encode()

class EncryptedData(BaseModel):
    aes_nonce: str
    chacha_nonce: str
    ciphertext: str

def encrypt_data(plaintext: str) -> str:
    try:
        aes_cipher = AES.new(AES_KEY, AES.MODE_GCM)
        aes_ciphertext, aes_tag = aes_cipher.encrypt_and_digest(plaintext.encode())

        chacha_cipher = ChaCha20.new(key=CHACHA_KEY)
        combined = aes_ciphertext + aes_tag
        final_ciphertext = chacha_cipher.encrypt(combined)

        encrypted_data = EncryptedData(
            aes_nonce=base64.b64encode(aes_cipher.nonce).decode(),
            chacha_nonce=base64.b64encode(chacha_cipher.nonce).decode(),
            ciphertext=base64.b64encode(final_ciphertext).decode()
        )

        return base64.b64encode(encrypted_data.json().encode()).decode()
    except Exception as e:
        logger.error(f"Encryption failed: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to encrypt data")

def decrypt_data(encrypted_str: str) -> str:
    try:
        decoded = base64.b64decode(encrypted_str).decode()
        encrypted_data = EncryptedData.parse_raw(decoded)

        aes_nonce = base64.b64decode(encrypted_data.aes_nonce)
        chacha_nonce = base64.b64decode(encrypted_data.chacha_nonce)
        ciphertext = base64.b64decode(encrypted_data.ciphertext)

        chacha_cipher = ChaCha20.new(key=CHACHA_KEY, nonce=chacha_nonce)
        combined = chacha_cipher.decrypt(ciphertext)

        aes_ciphertext = combined[:-16]
        aes_tag = combined[-16:]

        aes_cipher = AES.new(AES_KEY, AES.MODE_GCM, nonce=aes_nonce)
        plaintext = aes_cipher.decrypt_and_verify(aes_ciphertext, aes_tag)

        return plaintext.decode()
    except Exception as e:
        logger.error(f"Decryption failed: {str(e)}")
        raise HTTPException(status_code=400, detail="Failed to decrypt data")

@router.get("/view", response_model=List[s.UserRead])
def get_users(db: Session = Depends(get_db)):
    try:
        users = db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).all()
        return users
    except Exception as e:
        logger.error(f"Failed to fetch users: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to fetch users")

#fetch employee list from database to add account
@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    employees = db.query(m.Employee).all()
    return employees

#fetch roles list from database to add account
@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    roles = db.query(m.Roles).all()
    return roles

@router.post("/create", response_model=s.UserRead)
async def create_user(
    employee_id: int = Form(...),
    username: str = Form(...),
    email: str = Form(...),
    password: str = Form(...),
    role_name: str = Form(...),
    db: Session = Depends(get_db)
):
    try:
        existing_user = db.query(m.User).filter(
            (m.User.username == username) | 
            (m.User.email == email)
        ).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Username or Email already exists")

        encrypted_password = encrypt_data(password)

        new_user = m.User(
            employee_id=employee_id,
            username=username,
            email=email,
            password=encrypted_password
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        role = db.query(m.Roles).filter_by(roles_name=role_name).first()
        if not role:
            raise HTTPException(status_code=400, detail="Role not found")

        user_role = m.UserRoles(user_id=new_user.user_id, roles_id=role.roles_id)
        db.add(user_role)
        db.commit()

        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        logger.error(f"Error creating user: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to create user")

@router.put("/update/{user_id}", response_model=s.UserRead)
def update_user(
    user_id: int,
    username: str = Form(...),
    email: str = Form(...),
    password: Optional[str] = Form(None),
    role_name: Optional[str] = Form(None),
    db: Session = Depends(get_db)
):
    try:
        user = db.query(m.User).filter_by(user_id=user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        user.username = username
        user.email = email

        if password:
            user.password = encrypt_data(password)

        if role_name:
            role = db.query(m.Roles).filter_by(roles_name=role_name).first()
            if not role:
                raise HTTPException(status_code=400, detail="Role not found")
            db.query(m.UserRoles).filter_by(user_id=user_id).delete()
            db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

        db.commit()
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        logger.error(f"Error updating user: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to update user")

@router.delete("/delete/{user_id}", response_model=s.UserRead)
async def delete_user(
    user_id: int = Path(..., title="The ID of the account to delete"),
    db: Session = Depends(get_db)
):
    try:
        user = db.query(m.User).filter_by(user_id=user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="Account not found")

        db.delete(user)
        db.commit()
        return user
    except Exception as e:
        db.rollback()
        logger.error(f"Error deleting user: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to delete account")
