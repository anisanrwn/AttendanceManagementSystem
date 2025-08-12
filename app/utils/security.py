import pyotp
import io
import qrcode
import secrets
import base64
from fastapi import HTTPException

def generate_qr_code(user_email: str, secret: str, issuer_name: str = "AttendanceSystem"):
    """
    Generate QR code for MFA setup
    Args:
        user_email: User's email address
        secret: MFA secret key
        issuer_name: Name of your application
    Returns:
        Base64-encoded QR code image as data URI
    """
    try:
        # Create TOTP object
        totp = pyotp.TOTP(secret)
        
        # Generate provisioning URI for authenticator apps
        provisioning_uri = totp.provisioning_uri(
            name=user_email,
            issuer_name=issuer_name
        )
        
        # Create QR code
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(provisioning_uri)
        qr.make(fit=True)
        
        # Create QR code image
        qr_image = qr.make_image(fill_color="black", back_color="white")
        
        # Convert to base64 string
        img_buffer = io.BytesIO()
        qr_image.save(img_buffer, format='PNG')
        img_buffer.seek(0)
        
        # Encode as base64 data URI
        qr_code_base64 = base64.b64encode(img_buffer.getvalue()).decode('utf-8')
        
        return f"data:image/png;base64,{qr_code_base64}"
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating QR code: {str(e)}")

def verify_mfa_token(secret: str, token: str):
    """
    Verify MFA token
    Args:
        secret: User's MFA secret
        token: 6-digit token from authenticator app
    Returns:
        Boolean indicating if token is valid
    """
    try:
        totp = pyotp.TOTP(secret)
        return totp.verify(token, valid_window=1)  # Allow 1 time step tolerance
    except Exception:
        return False

def generate_mfa_secret():
    """
    Generate a cryptographically secure secret for MFA/TOTP authentication.
    Returns a base32-encoded secret string that can be used with authenticator apps.
    """
    # Generate 32 random bytes (256 bits) for high security
    random_bytes = secrets.token_bytes(32)
    
    # Encode as base32 (required format for TOTP secrets)
    secret = base64.b32encode(random_bytes).decode('utf-8')
    
    # Remove padding characters for cleaner secret
    return secret.rstrip('=')

# Alternative using pyotp's built-in method
def generate_mfa_secret_simple():
    """
    Generate MFA secret using pyotp's built-in method.
    Returns a base32-encoded secret string.
    """
    return pyotp.random_base32()


# Example usage:
if __name__ == "__main__":
    # Method 1: Custom implementation
    secret1 = generate_mfa_secret()
    print(f"Custom secret: {secret1}")
    
    # Method 2: PyOTP built-in
    secret2 = generate_mfa_secret_simple()
    print(f"PyOTP secret: {secret2}")
    
    # Verify the secret works with TOTP
    totp = pyotp.TOTP(secret1)
    current_token = totp.now()
    print(f"Current TOTP token: {current_token}")
    
    # Generate QR code URI for authenticator apps
    provisioning_uri = totp.provisioning_uri(
        name="user@example.com",
        issuer_name="Your App Name"
    )
    print(f"QR Code URI: {provisioning_uri}")