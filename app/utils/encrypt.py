from Crypto.Cipher import AES, ChaCha20
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad, unpad
import base64
import os
import logging
from pydantic import BaseModel

logger = logging.getLogger(__name__)

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
        raise

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
        raise
