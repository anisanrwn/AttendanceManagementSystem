import bcrypt

def hash_password(password: str) -> str:
     return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(input_password: str, stored_hash: str) -> bool:
     return bcrypt.checkpw(input_password.encode(), stored_hash.encode())