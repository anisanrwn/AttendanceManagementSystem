from fastapi import APIRouter, Depends, HTTPException, Form, Path
from sqlalchemy.orm import Session, joinedload
from app.database import get_db
from app.models import model as m
from app.schemas import schemas as s
from app.utils.encrypt import encrypt_data
from app.utils.logger import log_activity
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
        log_activity(db, "Fetched users", "Successfully fetched users list")
        return users
    except Exception as e:
        log_activity(db, "Fetch users failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch users")

@router.get("/available_employees", response_model=List[s.EmployeeRead])
async def get_available_employees(db: Session = Depends(get_db)):
    try:
        employees = db.query(m.Employee).all()
        log_activity(db, "Fetched employees", "Successfully fetched employees list")
        return employees
    except Exception as e:
        log_activity(db, "Fetch employees failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch employees")

@router.get("/available_roles", response_model=List[s.RoleRead])
async def get_available_roles(db: Session = Depends(get_db)):
    try:
        roles = db.query(m.Roles).all()
        log_activity(db, "Fetched roles", "Successfully fetched roles list")
        return roles
    except Exception as e:
        log_activity(db, "Fetch roles failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to fetch roles")

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

        # Directly hash the password
        hashed_password = hash_password(password)

        new_user = m.User(
            employee_id=employee_id,
            username=username,
            email=email,
            password=hashed_password
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

        log_activity(db, "Created user", f"User {username} created successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == new_user.user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity(db, "User creation failed", str(e))
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
            hashed_password = hash_password(password)
            user.password = hashed_password

        if role_name:
            role = db.query(m.Roles).filter_by(roles_name=role_name).first()
            if not role:
                raise HTTPException(status_code=400, detail="Role not found")
            db.query(m.UserRoles).filter_by(user_id=user_id).delete()
            db.add(m.UserRoles(user_id=user_id, roles_id=role.roles_id))

        db.commit()
        log_activity(db, "Updated user", f"User {username} updated successfully")
        return db.query(m.User).options(
            joinedload(m.User.employee),
            joinedload(m.User.roles)
        ).filter(m.User.user_id == user_id).first()
    except HTTPException:
        db.rollback()
        raise
    except Exception as e:
        db.rollback()
        log_activity(db, "User update failed", str(e))
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
        log_activity(db, "Deleted user", f"User {user_id} deleted successfully")
        return user
    except Exception as e:
        db.rollback()
        log_activity(db, "User deletion failed", str(e))
        raise HTTPException(status_code=500, detail="Failed to delete account")
