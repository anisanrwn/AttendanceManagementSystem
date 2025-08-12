import cv2
import numpy as np
import face_recognition
import base64

def read_image(image_bytes: bytes):
    np_array = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_array, cv2.IMREAD_COLOR)
    return img

def encode_face_multi(img) -> list:
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    encodings = face_recognition.face_encodings(img_rgb)
    if not encodings:
        raise ValueError("No face found in the image.")
    return [enc.tolist() for enc in encodings]

def verify_face_multi(image_base64, known_encodings, threshold=0.5):
    image_bytes = base64.b64decode(image_base64)
    np_arr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    rgb_img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    face_locations = face_recognition.face_locations(rgb_img)
    faces_encodings = face_recognition.face_encodings(rgb_img, face_locations)

    if not faces_encodings:
        return False, None

    largest_idx = 0
    if len(face_locations) > 1:
        areas = [(bottom - top) * (right - left) for (top, right, bottom, left) in face_locations]
        largest_idx = int(np.argmax(areas))

    unknown_encoding = faces_encodings[largest_idx]

    distances = [np.linalg.norm(np.array(enc) - unknown_encoding) for enc in known_encodings]
    match_count = sum(d < threshold for d in distances)
    is_verified = match_count >= (len(distances) / 2)

    return is_verified, distances
