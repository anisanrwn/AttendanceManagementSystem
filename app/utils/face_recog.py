import cv2
import numpy as np
import face_recognition
import base64

def read_image(image_bytes: bytes):
    np_array = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_array, cv2.IMREAD_COLOR)
    return img

def encode_face(img) -> list:
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    encodings = face_recognition.face_encodings(img_rgb)
    if encodings:
        return encodings[0].tolist()
    else:
        raise ValueError("No face found in the image.")


def verify_face(image_base64, known_encoding, threshold=0.6):
    image_bytes = base64.b64decode(image_base64)
    np_arr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    faces_encodings = face_recognition.face_encodings(rgb_img)

    if not faces_encodings:
        return False, None  # Tidak ada wajah terdeteksi

    unknown_encoding = faces_encodings[0]
    distance = np.linalg.norm(np.array(known_encoding) - np.array(unknown_encoding))
    is_verified = distance <= threshold

    return is_verified, distance
