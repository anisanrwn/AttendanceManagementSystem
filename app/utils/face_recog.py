import cv2
import numpy as np
import face_recognition
from PIL import Image


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

def verify_face(image: Image.Image, known_encoding: list) -> bool:
    np_image = np.array(image)
    face_locations = face_recognition.face_locations(np_image)
    face_encodings = face_recognition.face_encodings(np_image, face_locations)

    if not face_encodings:
        return False

    result = face_recognition.compare_faces([np.array(known_encoding)], face_encodings[0])
    return result[0]