function setupFaceRecognition() {
  const video = document.getElementById('faceVideo');
  const startCameraBtn = document.getElementById('startCameraBtn');
  const captureFaceBtn = document.getElementById('captureFaceBtn');
  const faceStatus = document.getElementById('faceStatus');
  let stream = null;

  startCameraBtn.onclick = async () => {
    try {
      stream = await navigator.mediaDevices.getUserMedia({ video: true });
      video.srcObject = stream;
      captureFaceBtn.disabled = false;
      faceStatus.textContent = "Camera started. Please position your face.";
    } catch (err) {
      faceStatus.textContent = "Could not access camera: " + err.message;
    }
  };

  captureFaceBtn.onclick = async () => {
    if (!stream) {
      faceStatus.textContent = "Camera not started yet.";
      return;
    }
    // Capture frame dari video
    const canvas = document.createElement('canvas');
    canvas.width = video.videoWidth || 320;
    canvas.height = video.videoHeight || 240;
    const ctx = canvas.getContext('2d');
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
    const imageBase64 = canvas.toDataURL('image/jpeg').split(',')[1]; // tanpa prefix

    // Kirim data ke backend
    faceStatus.textContent = "Verifying face...";
    
    // Ambil lokasi terakhir dari global currentPosition
    const lat = currentPosition?.lat || 0;
    const lng = currentPosition?.lng || 0;

    // Ambil employee_id dari sessionStorage (pastikan kamu set ini saat login)
    const employeeId = sessionStorage.getItem('employee_id');
    if (!employeeId) {
      faceStatus.textContent = "Session expired, please login again.";
      return;
    }

    try {
      const response = await fetch('http://localhost:8000/attendance/clockin', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          employee_id: parseInt(employeeId),
          image_base64: imageBase64,
          clock_in_latitude: lat,
          clock_in_longitude: lng,
          clock_in_reason: ''
        }),
      });
      const data = await response.json();

      if (response.ok && data.face_verified) {
        faceStatus.textContent = "Face verified! Attendance recorded.";
        // Optional: stop camera stream after success
        stream.getTracks().forEach(track => track.stop());
        captureFaceBtn.disabled = true;
        startCameraBtn.disabled = true;
      } else {
        faceStatus.textContent = "Face not recognized. Please try again.";
      }
    } catch (error) {
      faceStatus.textContent = "Error verifying face: " + error.message;
    }
  };
}
