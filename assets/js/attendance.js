import { requestLocationAccess, stopLocationTracking, insideGeofence, currentPosition } from './loctrack.js';
import { startFaceRecognition, captureAndVerifyFace } from './facerecog.js';
import { showAlert } from './alert.js';
import { startLivenessCheck } from './liveness.js';

let attendanceAction = null;
let stream = null;
let holidays = [];
let serverOffset = 0;

// Live Clock
const punchInTime = "08:00";
const punchOutTime = "16:45";

function formatTime(ms) {
  const sec = Math.floor(Math.abs(ms) / 1000);
  const h = sec / 3600 | 0;
  const m = sec / 60 % 60 | 0;
  const s = sec % 60;
  return [h, m, s].map(n => String(n).padStart(2, '0')).join(':');
}

function formatDuration(seconds) {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = Math.floor(seconds % 60);
  return `${String(hrs).padStart(2, '0')}:${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
}

function getGreeting(hour) {
  if (hour < 12) return "Good Morning!";
  if (hour < 17) return "Good Afternoon!";
  if (hour < 20) return "Good Evening!";
  return "Good Night!";
}

async function fetchHolidays() {
  try {
    const response = await fetch("http://localhost:8000/attendance/holidays");
    if (!response.ok) throw new Error("Failed to fetch holidays");
    const data = await response.json();
    holidays = data.holidays || [];
  } catch (error) {
    console.error("Error fetching holidays:", error);
  }
}

async function getServerTime() {
  try {
    const res = await fetch('http://localhost:8000/attendance/server-time');
    if (!res.ok) throw new Error("Failed to fetch server time");

    const { serverTime } = await res.json();
    return new Date(serverTime);
  } catch (err) {
    console.error("Error fetching server time:", err);
    return new Date();
  }
}

async function initTimeSync() {
  await fetchHolidays(); 
  const serverDate = await getServerTime();
  const localDate = new Date();
  serverOffset = serverDate.getTime() - localDate.getTime();
}

export function getTrustedNow() {
  return new Date(Date.now() + serverOffset);
}

async function updateClock() {
  const now = getTrustedNow();
  const hour = now.getHours();
  const greeting = getGreeting(hour);

  const digitalClock = document.getElementById("digitalClock");
  const currentDate = document.getElementById("currentDate");
  const greetingText = document.getElementById("greeting-text");
  const attendanceStatus = document.getElementById("attendance-status");
  const countdownText = document.getElementById("countdown-text");

  digitalClock.textContent = now.toLocaleTimeString();
  currentDate.textContent = now.toDateString();
  greetingText.textContent = greeting;

  const punchIn = toTimeToday(punchInTime);
  const punchOut = toTimeToday(punchOutTime);

  const status = document.getElementById("status").textContent;
  const isWeekend = now.getDay() === 0 || now.getDay() === 6;
  const isHoliday = holidays.includes(now.toISOString().split("T")[0]);

   if (isHoliday) {
     attendanceStatus.textContent = "Happy Holiday!";
     countdownText.textContent = "Enjoy your day off!";
     punchInBtn.disabled = true;

   } else if (isWeekend) {
     attendanceStatus.textContent = "Happy Weekend!";
     countdownText.textContent = "Enjoy your weekend!";
     punchInBtn.disabled = true;

  } else if (isWeekend) {
  attendanceStatus.textContent = "Weekend detected, but attendance is open.";
  countdownText.textContent = "You may still clock in.";
  
  } else if (status === "Absent") {
    const maxClockIn = toTimeToday("13:00");
    if (now > maxClockIn) {
      attendanceStatus.textContent = "Clock-in time is over.";
      countdownText.textContent = "You cannot clock in anymore.";
      punchInBtn.disabled = true;

    } else if (now < punchIn) {
      attendanceStatus.textContent = `Office hour starts at ${punchInTime}`;
      countdownText.textContent = `Starts in ${formatTime(punchIn - now)}`;

    } else {
      attendanceStatus.textContent = `Office hour started at ${punchInTime}`;
      countdownText.textContent = `You're late by ${formatTime(now - punchIn)}`;
    }
  } else if (status === "Punch In") {
    attendanceStatus.textContent = `Happy working! Office ends at ${punchOutTime}`;
    countdownText.textContent = `Ends in ${now < punchOut ? formatTime(punchOut - now) : "00:00:00"}`;
  } else if (status === "Punch Out") {
    attendanceStatus.textContent = `Rest well!`;
    countdownText.textContent = `See you tomorrow`;
  } else {
    attendanceStatus.textContent = `--`;
    countdownText.textContent = `--`;
  }
}

function toTimeToday(timeStr) {
  const [h, m] = timeStr.split(':').map(Number);
  const now = getTrustedNow();
  const date = new Date(now.getFullYear(), now.getMonth(), now.getDate(), h, m, 0);
  return date;
}

initTimeSync().then(() => {
  updateClock();
});

setInterval(updateClock, 1000);

// take attendance
const punchInBtn = document.getElementById("punchInBtn");
const punchOutBtn = document.getElementById("punchOutBtn");
const attendancePage = document.getElementById("attendance-page");
const stepPage = document.getElementById("step-page");
const backToAttendanceBtn = document.getElementById("backToAttendanceBtn");

// Initialize the location tracking system
document.addEventListener('DOMContentLoaded', async function() {
    setupEventListeners();
    await resetToAttendancePage(); 
});

// Set up event listeners
function setupEventListeners() {
  document.getElementById('punchInBtn').addEventListener('click', () => {
      attendanceAction = 'clock_in'; 
      attendancePage.style.display = 'none';
      stepPage.style.display = 'block';
      goToStep(1);
  });

  document.getElementById('punchOutBtn').addEventListener('click', () => {
      attendanceAction = 'clock_out'; 
      attendancePage.style.display = 'none';
      stepPage.style.display = 'block';
      goToStep(1);
  });

  document.getElementById('allowLocationBtn').addEventListener('click', () => {
      requestLocationAccess();
  });
  
  document.getElementById('btn-back-step').addEventListener('click', () => {
      stopLocationTracking();
      goToStep(1);
  });
  
  document.getElementById('verifyLocationBtn').addEventListener('click', async () => {
    if (insideGeofence || document.getElementById('reasonText').value.trim() !== '') {
      goToStep(3);
      stream = await startFaceRecognition();

      const passed = await handleLivenessCheck();

      if (passed) {
        if (stream) {
          stream.getTracks().forEach(track => track.stop());
          stream = null;
        }
        stream = await startFaceRecognition();
        document.getElementById('captureFaceBtn').disabled = false;
      }
    } else {
      showAlert('warning', 'Please provide a reason why you are not in the designated area.');
    }
  });
}

export function goToStep(stepNumber) {
  document.querySelectorAll('.step-container').forEach(container => {
    container.classList.remove('active-step');
    container.style.display = 'none';
  });

  const currentStepContainer = document.getElementById(`step${stepNumber}Container`);
  if (!currentStepContainer) {
    alert(`step${stepNumber}Container NOT FOUND!`);
    return;
  }

  currentStepContainer.classList.add('active-step');
  currentStepContainer.style.display = 'block';

  updateProgressTracker(stepNumber);
}

function updateProgressTracker(activeStep) {
    document.querySelectorAll('.progress-step').forEach((step, index) => {
        step.classList.remove('active', 'completed');
        if (index + 1 < activeStep) {
            step.classList.add('completed');
        } else if (index + 1 === activeStep) {
            step.classList.add('active');
        }
    });
}

backToAttendanceBtn.addEventListener("click", async (e) => {
  e.preventDefault();
  Swal.fire({
    title: 'Are you sure?',
    text: "You will not be counted as present unless you complete attendance.",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#696cff',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, go back!',
    cancelButtonText: 'Cancel'
  }).then(async (result) => {
    if (result.isConfirmed) {
      try {
        await resetToAttendancePage();
      } catch (error) {
        console.error("Error:", error);
      }
    }
  });
});

let isProcessing = false;

captureFaceBtn.onclick = async () => {
  if (isProcessing) return;
  isProcessing = true;
  captureFaceBtn.disabled = true;

  const reason = document.getElementById('reasonText')?.value.trim() || '';
  const locationPayload = {
    lat: currentPosition?.lat,
    lng: currentPosition?.lng,
    reason: reason,
  };

  const result = await captureAndVerifyFace(stream, locationPayload, attendanceAction);
  if (result) {
    const { response, data, stream } = result;

    if (response.ok && data.face_verified) {
      await Swal.fire({
        icon: 'success',
        title: 'Success!',
        text: `Face verified and ${attendanceAction.replace('_', ' ')} recorded.`,
        confirmButtonText: 'OK'
      });

      if (stream) {
        stream.getTracks().forEach(track => track.stop());
      }

      stepPage.style.display = "none";
      attendancePage.style.display = "block";

      await resetToAttendancePage();

      if (attendanceAction === 'clock_in') {
        punchInBtn.disabled = true;
        punchOutBtn.disabled = false;
      } else if (attendanceAction === 'clock_out') {
        punchOutBtn.disabled = true;
      }
    } else {
      await Swal.fire({
        icon: 'error',
        title: 'Face Not Recognized',
        text: 'Please try again.',
        confirmButtonText: 'Retry'
      });
    }
    
    isProcessing = false;
    captureFaceBtn.disabled = false;
  }
}

async function resetToAttendancePage() {
  stepPage.style.display = "none";
  attendancePage.style.display = "block";

  const employeeId = sessionStorage.getItem('employee_id');
  if (!employeeId) {
    console.error("Employee ID not found.");
    return;
  }

  try {
    const response = await fetch(`http://localhost:8000/attendance/attendance-status?employee_id=${employeeId}`);
    if (!response.ok) throw new Error('Failed to fetch attendance data.');

    const data = await response.json();
    document.getElementById("inTime").textContent = data.clock_in ?? "--:--";
    document.getElementById("outTime").textContent = data.clock_out ?? "--:--";
    document.getElementById("totalHours").textContent = data.totalHours != null ? formatDuration(data.totalHours) : "--";

    const statusText = data.attendance_status ?? "Absent";
    const statusBadge = document.getElementById("status");
    statusBadge.textContent = statusText;

    switch (statusText) {
      case "Punch In":
        statusBadge.className = "badge bg-label-primary";
        punchInBtn.disabled = true;
        punchOutBtn.disabled = false;
        break;
      case "Punch Out":
        statusBadge.className = "badge bg-label-success";
        punchInBtn.disabled = true;
        punchOutBtn.disabled = true;
        break;
      case "Permit":
        statusBadge.className = "badge bg-label-info";
        punchInBtn.disabled = true;
        punchOutBtn.disabled = true;
        break;
      case "Absent":
      default:
        statusBadge.className = "badge bg-label-danger";
        punchInBtn.disabled = false;
        punchOutBtn.disabled = true;
        break;
    }

  } catch (error) {
    console.error("Error:", error);
  }
}

async function handleLivenessCheck() {
  while (true) {
    await Swal.fire({
      title: 'Liveness Check Required',
      text: 'For verification, please blink at least twice within the next few seconds. No need to rush, just blink naturally.',
      icon: 'info',
      confirmButtonText: 'Start'
    });

    const passedLiveness = await startLivenessCheck();

    if (passedLiveness) {
      await Swal.fire({
        title: 'Blink Detected!',
        text: 'Liveness check passed..',
        icon: 'success',
        confirmButtonText: 'OK'
      });
      return true; 
    } else {
      const retry = await Swal.fire({
        icon: 'error',
        title: 'Liveness Check Failed',
        text: 'We couldn’t detect enough blinks. Do you want to retry?',
        showCancelButton: true,
        confirmButtonText: 'Retry',
        cancelButtonText: 'Cancel'
      });

      if (!retry.isConfirmed) {
        return false;
      }
    }
  }
}

