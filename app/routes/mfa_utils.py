from cryptography.fernet import Fernet
import os

FERNET_KEY = os.getenv("MFA_FERNET_KEY")  # wajib di production
fernet = Fernet(FERNET_KEY) if FERNET_KEY else None

def encrypt_secret(secret: str) -> str:
    """Encrypt MFA secret before storing in DB"""
    if not fernet:
        return secret
    return fernet.encrypt(secret.encode()).decode()

def decrypt_secret(token: str) -> str:
    """Decrypt MFA secret from DB"""
    if not fernet:
        return token
    return fernet.decrypt(token.encode()).decode()
