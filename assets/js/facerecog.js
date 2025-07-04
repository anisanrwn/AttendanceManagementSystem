import { showAlert } from './alert.js';
import { currentPosition } from './loctrack.js';

export async function startFaceRecognition() {
  const video = document.getElementById('faceVideo');
  
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ video: true });
    video.srcObject = stream;

    document.getElementById('captureFaceBtn').disabled = false;
    Swal.fire({
    title: 'Face recognition started',
    text: "Please position your face in front of the camera and click the Capture and Verify button to proceed.",
    icon: 'info',
    confirmButtonText: 'OK'
    })
    return stream;
  } catch (err) {
    showAlert('error', 'Could not access camera: ' + err.message);
    return null;
  }
}

export async function captureAndVerifyFace(stream, locationPayload, attendanceAction) {
  console.log('Attendance Action:', attendanceAction);
  const video = document.getElementById('faceVideo');
  
  if (!stream) {
    showAlert('error', 'Camera not started yet.');
    return null;
  }

  // Capture frame from video
  const canvas = document.createElement('canvas');
  canvas.width = video.videoWidth || 320;
  canvas.height = video.videoHeight || 240;
  const ctx = canvas.getContext('2d');
  ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
  const imageBase64 = canvas.toDataURL('image/jpeg').split(',')[1];

  const lat = locationPayload?.lat || null;
  const lng = locationPayload?.lng || null;
  const reason = locationPayload?.reason || '';
  const employeeId = sessionStorage.getItem('employee_id');

  if (!employeeId) {
    showAlert('error', 'Session expired, please login again.');
    return null;
  }

  const endpoint = attendanceAction === 'clock_in' ? '/clockin' : '/clockout';
  const bodyPayload = {
    employee_id: parseInt(employeeId),
    image_base64: imageBase64,
  };

  if (attendanceAction === 'clock_in') {
    bodyPayload.clock_in_latitude = lat;
    bodyPayload.clock_in_longitude = lng;
    bodyPayload.clock_in_reason = reason;
  } else {
    bodyPayload.clock_out_latitude = lat;
    bodyPayload.clock_out_longitude = lng;
    bodyPayload.clock_out_reason = reason;
  }

  try {
    const response = await fetch(`http://localhost:8000/attendance${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(bodyPayload),
    });

    const data = await response.json();

    if (response.ok && data.face_verified) {
      showAlert('success', `${attendanceAction.replace('_', ' ')} berhasil.`);
    } else {
      showAlert('error', 'Face not recognized. Please try again.');
    }

    return { response, data, stream };
  } catch (error) {
    showAlert('error', 'Error verifying face: ' + error.message);
    return null;
  }
}
