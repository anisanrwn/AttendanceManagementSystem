import { getTrustedNow } from './attendance.js';

let blinkCount = 0;
let lastEAR = 1.0;
let isLivenessActive = false;
let blinkStart = null;
let blinkDetected = false;
let lastBlinkTime = 0;  

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

export async function startLivenessCheck() {
  const videoElement = document.getElementById('faceVideo');

  document.getElementById('captureFaceBtn').disabled = true;

  return new Promise((resolve, reject) => {
    blinkCount = 0;
    lastEAR = 1.0;
    isLivenessActive = true;

    const faceMesh = new window.FaceMesh({
      locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/face_mesh/${file}`,
    });

    faceMesh.setOptions({
      maxNumFaces: 1,
      refineLandmarks: true,
      minDetectionConfidence: 0.5,
      minTrackingConfidence: 0.5,
    });

    const leftEyeIndices = [33, 160, 158, 133, 153, 144];
    const rightEyeIndices = [263, 387, 385, 362, 380, 373];
    

    faceMesh.onResults((results) => {
      if (results.multiFaceLandmarks && results.multiFaceLandmarks.length > 0) {
        const landmarks = results.multiFaceLandmarks[0];

        const leftEAR = calculateEAR(landmarks, leftEyeIndices);
        const rightEAR = calculateEAR(landmarks, rightEyeIndices);
        const currentEAR = (leftEAR + rightEAR) / 2.0;
        const earDrop = lastEAR - currentEAR;
        const now = getTrustedNow();
        console.log(`Current EAR: ${currentEAR.toFixed(4)}, Last EAR: ${lastEAR.toFixed(4)}, Blink Count: ${blinkCount}`);

        if (!blinkDetected && (lastEAR - currentEAR > 0.08) && currentEAR < 0.22) {
          blinkStart = Date.now();
          blinkDetected = true;
          console.log("Blink start detected...");
        }

        if (earDrop > 0.12 && currentEAR < 0.25) {
            if (now - lastBlinkTime > 300) {  
                blinkCount++;
                lastBlinkTime = now;
                console.log(`Blink Detected! Current EAR: ${currentEAR.toFixed(4)}, Last EAR: ${lastEAR.toFixed(4)}, Blink Count: ${blinkCount}`);
            } else {
                console.log('Ignored: Blink too fast, possible spoof.');
            }
        }

        lastEAR = currentEAR;

        if (blinkCount > 1) {
          console.log('Liveness PASSED');
          isLivenessActive = false;
          camera.stop();
          faceMesh.close();
          resolve(true);
        }
      } else {
        console.log('No face landmarks detected.');
      }
    });

    console.log('Starting Camera...');
    const camera = new window.Camera(videoElement, {
      onFrame: async () => {
        if (!isLivenessActive) return;
        console.log('Sending frame to FaceMesh...');
        await faceMesh.send({ image: videoElement });
      },
      width: 640,
      height: 480,
    });

    camera.start();

    setTimeout(() => {
      if (blinkCount < 1) {
        console.log('Liveness Check Timeout');
        isLivenessActive = false;
        camera.stop();
        faceMesh.close();
        resolve(false);
      }
    }, 5000);
  });
}
