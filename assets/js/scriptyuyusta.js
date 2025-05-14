// Function to format time as HH:MM:SS
const punchInTime = "08:00";
const punchOutTime = "17:00";
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

initTimeSync().then(() => {
  updateClock();
});

setInterval(updateClock, 1000);