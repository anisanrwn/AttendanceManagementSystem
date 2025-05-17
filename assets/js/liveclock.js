// Function to format time as HH:MM:SS
const punchInTime = "08:00";
const punchOutTime = "16:45";

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
  serverOffset = serverDate - localDate;
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

const punchInBtn = document.getElementById("punchInBtn");
const punchOutBtn = document.getElementById("punchOutBtn");
const attendancePage = document.getElementById("attendance-page");
const stepPage = document.getElementById("step-page");
const backToAttendanceBtn = document.getElementById("backToAttendanceBtn");

let hasPunchedIn = false;

punchInBtn.addEventListener("click", () => {
    attendancePage.style.display = "none";
    stepPage.style.display = "block";
    document.getElementById("step1Container").classList.add("active-step");
    document.getElementById("step2Container").classList.remove("active-step");
    document.getElementById("step3Container").style.display = "none";
    
    hasPunchedIn = true;
    punchInBtn.disabled = true;
    punchOutBtn.disabled = true;
});

backToAttendanceBtn.addEventListener("click", (e) => {
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
        }).then((result) => {
            if (result.isConfirmed) {
            // Go back to attendance page
            stepPage.style.display = "none";
            attendancePage.style.display = "block";
            document.getElementById("step1Container").classList.remove("active-step");

            // Reset Punch state
            hasPunchedIn = false;
            punchInBtn.disabled = false;
            punchOutBtn.disabled = true;

            // Clear punch in/out times
            document.getElementById("inTime").textContent = "--:--";
            document.getElementById("outTime").textContent = "--:--";
            document.getElementById("totalHours").textContent = "--";
            document.getElementById("status").textContent = "Belum Absen";
            document.getElementById("status").className = "badge bg-label-warning";
        }
    });
});
