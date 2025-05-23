import bcrypt
import re
from fastapi import HTTPException 

def hash_password(password: str) -> str:
     return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(input_password: str, stored_hash: str) -> bool:
     return bcrypt.checkpw(input_password.encode(), stored_hash.encode())

def validate_password_strength(password: str):
    if len(password) < 8:
        raise HTTPException(status_code=400, detail="Password must be at least 8 characters long")
    if not re.search(r'[A-Z]', password):
        raise HTTPException(status_code=400, detail="Password must contain at least one uppercase letter")
    if not re.search(r'[a-z]', password):
        raise HTTPException(status_code=400, detail="Password must contain at least one lowercase letter")
    if not re.search(r'\d', password):
        raise HTTPException(status_code=400, detail="Password must contain at least one digit")
    if not re.search(r'[.@$!%*?&]', password):
        raise HTTPException(status_code=400, detail="Password must contain at least one special character (.@$!%*?&)")