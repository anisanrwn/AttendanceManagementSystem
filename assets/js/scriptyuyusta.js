// Function to format time as HH:MM:SS
function formatTime(ms) {
  const sec = Math.floor(Math.abs(ms) / 1000);
  const h = sec / 3600 | 0;
  const m = sec / 60 % 60 | 0;
  const s = sec % 60;
  return [h, m, s].map(n => String(n).padStart(2, '0')).join(':');
}

// Fetch server time and synchronize
async function getServerTime() {
  const res = await fetch('http://localhost:8000/attendance/server-time');
  const { serverTime } = await res.json();
  return new Date(serverTime);
}

let serverOffset = 0;

async function initTimeSync() {
  const serverDate = await getServerTime();
  const localDate = new Date();
  serverOffset = serverDate - localDate; // in milliseconds
}

function getTrustedNow() {
  return new Date(Date.now() + serverOffset);
}

// Update live clock on UI
function updateClock() {
  const now = getTrustedNow();
  document.getElementById("digitalClock").textContent = now.toLocaleTimeString();
  document.getElementById("currentDate").textContent = now.toDateString();
}

// Countdown Loop and Status Update
function countdownLoop() {
  const now = getTrustedNow();
  const [inH, inM] = punchInTime.split(":");
  const [outH, outM] = punchOutTime.split(":");

  const punchInTarget = new Date(now);
  punchInTarget.setHours(inH, inM, 0, 0);

  const punchOutTarget = new Date(now);
  punchOutTarget.setHours(outH, outM, 0, 0);

  let diff, label;
  const statusText = document.getElementById("attendance-status");

  if (!hasPunchedIn) {
    diff = punchInTarget - now;
    label = diff > 0 ? `Clock in starts in ${formatTime(diff)}` : `You're late by ${formatTime(-diff)}`;
    statusText.textContent = diff > 0 ? `Office hour starts at ${punchInTime}` : `You're late. Please clock in.`;
  } else if (!hasPunchedOut) {
    diff = punchOutTarget - now;
    label = diff > 0 ? `Clock out in ${formatTime(diff)}` : `Working hours ended`;
    statusText.textContent = diff > 0 ? "Happy working!" : "You can clock out now.";
  } else {
    label = "Rest well ✨";
    statusText.textContent = "See you tomorrow!";
  }

  document.getElementById("countdown-text").textContent = label;
}

// Punch In Event
let hasPunchedIn = localStorage.getItem("hasPunchedIn") === "true";
let hasPunchedOut = localStorage.getItem("hasPunchedOut") === "true";

document.getElementById("punchInBtn").addEventListener("click", function () {
  document.getElementById("attendance-page").style.display = "none";
  document.getElementById("step-page").style.display = "block";

  hasPunchedIn = true;
  localStorage.setItem("hasPunchedIn", "true");

  document.getElementById("punchOutBtn").disabled = false;
  document.getElementById("status").textContent = "Clocked In";
  document.getElementById("status").classList.remove("bg-label-warning");
  document.getElementById("status").classList.add("bg-label-success");
  document.getElementById("punchInBtn").disabled = true;
});

document.getElementById("punchOutBtn").addEventListener("click", function () {
  hasPunchedOut = true;
  localStorage.setItem("hasPunchedOut", "true");

  document.getElementById("status").textContent = "Clocked Out";
  document.getElementById("status").classList.remove("bg-label-success");
  document.getElementById("status").classList.add("bg-label-danger");
  document.getElementById("punchOutBtn").disabled = true;
});

function restorePunchStatus() {
  if (hasPunchedIn) {
    document.getElementById("punchInBtn").disabled = true;
    document.getElementById("punchOutBtn").disabled = false;
    document.getElementById("status").textContent = "Clocked In";
    document.getElementById("status").classList.remove("bg-label-warning");
    document.getElementById("status").classList.add("bg-label-success");
  }

  if (hasPunchedOut) {
    document.getElementById("punchOutBtn").disabled = true;
    document.getElementById("status").textContent = "Clocked Out";
    document.getElementById("status").classList.remove("bg-label-success");
    document.getElementById("status").classList.add("bg-label-danger");
  }
}

initTimeSync().then(() => {
  updateClock();
  countdownLoop();
  setInterval(updateClock, 1000);
  setInterval(countdownLoop, 1000);
  restorePunchStatus();  // Restore punch state on page load
});