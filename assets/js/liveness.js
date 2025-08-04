import { getTrustedNow } from './attendance.js';
import { showAlert } from './alert.js';

let blinkCount = 0;
let lastEAR = 1.0;
let isLivenessActive = false;
let blinkStart = null;
let blinkDetected = false;
let lastBlinkTime = 0;  
let hasVerifiedIdentity = false;
let faceMesh;
let camera;

function calculateEAR(landmarks, eyeIndices) {
  const p2p = (i, j) => Math.hypot(
    landmarks[i].x - landmarks[j].x,
    landmarks[i].y - landmarks[j].y
  );

  const vertical1 = p2p(eyeIndices[1], eyeIndices[5]);
  const vertical2 = p2p(eyeIndices[2], eyeIndices[4]);
  const horizontal = p2p(eyeIndices[0], eyeIndices[3]);
  console.log(`Vertical1: ${vertical1.toFixed(4)}, Vertical2: ${vertical2.toFixed(4)}, Horizontal: ${horizontal.toFixed(4)}`);
  return (vertical1 + vertical2) / (2.0 * horizontal);
}

// Silent capture 
async function silentVerify(videoElement) {
  const canvas = document.createElement('canvas');
  canvas.width = videoElement.videoWidth || 320;
  canvas.height = videoElement.videoHeight || 240;
  const ctx = canvas.getContext('2d');
  ctx.drawImage(videoElement, 0, 0, canvas.width, canvas.height);
  const imageBase64 = canvas.toDataURL('image/jpeg').split(',')[1];

  const employeeId = sessionStorage.getItem("employee_id");
  if (!employeeId) return false;
  try {
    const response = await fetch("http://localhost:8000/attendance/verify", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        employee_id: parseInt(employeeId),
        image_base64: imageBase64
      })
    });
    const data = await response.json();
    console.log("Verify result:", data.is_verified);
    console.log("All distances:", data.distances);
    console.log("Min distance:", data.min_distance);
    console.log("Max distance:", data.max_distance);
    console.log("Avg distance:", data.avg_distance);
    return response.ok && data.is_verified;
  } catch (err) {
    console.error("Silent verify error:", err);
    return false;
  }
}

export async function startLivenessCheck() {
  const videoElement = document.getElementById('faceVideo');
  document.getElementById('captureFaceBtn').disabled = true;

  return new Promise((resolve) => {
    blinkCount = 0;
    lastEAR = 1.0;
    isLivenessActive = true;
    hasVerifiedIdentity = false;
    blinkDetected = false;
    lastBlinkTime = 0;

    const leftEyeIndices = [33, 160, 158, 133, 153, 144];
    const rightEyeIndices = [263, 387, 385, 362, 380, 373];

    if (!faceMesh) {
      faceMesh = new window.FaceMesh({
        locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/face_mesh/${file}`,
      });

      faceMesh.setOptions({
        maxNumFaces: 1,
        refineLandmarks: true,
        minDetectionConfidence: 0.5,
        minTrackingConfidence: 0.5,
      });

      faceMesh.onResults(async (results) => {
        if (!isLivenessActive) return;

        if (results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
          const landmarks = results.multiFaceLandmarks[0];
          const leftEAR = calculateEAR(landmarks, leftEyeIndices);
          const rightEAR = calculateEAR(landmarks, rightEyeIndices);
          const currentEAR = (leftEAR + rightEAR) / 2.0;
          const earDrop = lastEAR - currentEAR;
          const now = getTrustedNow();

          if (!hasVerifiedIdentity) {
            hasVerifiedIdentity = true;
            const verified = await silentVerify(videoElement);
            if (!verified) {
              isLivenessActive = false;
              if (camera) camera.stop();
              Swal.fire({
                icon: 'error',
                title: 'You are not the valid user!',
                showConfirmButton: false,
                timer: 1000,
                timerProgressBar: true,
                allowOutsideClick: false,
                allowEscapeKey: false,
                didClose: () => {
                  window.location.href = "/html/Login.html";
                }
              });
              return;
            }
          }

          if (!blinkDetected && earDrop > 0.08 && currentEAR < 0.22) {
            blinkDetected = true;
            blinkStart = now;
            console.log("Blink start detected...");
          }

          if (earDrop > 0.12 && currentEAR < 0.25 && now - lastBlinkTime > 300) {
            blinkCount++;
            lastBlinkTime = now;
            console.log(`Blink Detected! Count: ${blinkCount}`);
          }

          lastEAR = currentEAR;

          if (blinkCount > 1) {
            console.log("Liveness PASSED");
            isLivenessActive = false;
            if (camera) camera.stop();
            resolve(true);
          }
        } else {
          console.log("No face detected");
        }
      });
    }

    if (camera) {
      camera.stop(); 
    }

    camera = new window.Camera(videoElement, {
      onFrame: async () => {
        if (isLivenessActive && faceMesh) {
          await faceMesh.send({ image: videoElement });
        }
      },
      width: 640,
      height: 480,
    });

    camera.start();

    const TIMEOUT_MS = 5000;
    setTimeout(() => {
      if (isLivenessActive && blinkCount < 1) {
        console.log("Liveness timeout");
        isLivenessActive = false;
        if (camera) camera.stop();
        resolve(false);
      }
    }, TIMEOUT_MS);
  });
}
