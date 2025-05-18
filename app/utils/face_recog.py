import cv2
import numpy as np
import face_recognition
from typing import List, Tuple


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

def find_best_match(known_encodings: List[np.ndarray], unknown_encoding: np.ndarray) -> Tuple[int, float]:
    """
    Cari indeks encoding terbaik dan jaraknya.
    Return (best_match_index, distance)
    """
    face_distances = face_recognition.face_distance(known_encodings, unknown_encoding)
    best_match_index = np.argmin(face_distances)
    return best_match_index, face_distances[best_match_index]

def is_match(known_encoding: np.ndarray, unknown_encoding: np.ndarray, tolerance: float = 0.6) -> bool:
    """
    Bandingkan apakah dua encoding cocok (default tolerance 0.6)
    """
    results = face_recognition.compare_faces([known_encoding], unknown_encoding, tolerance=tolerance)
    return results[0]