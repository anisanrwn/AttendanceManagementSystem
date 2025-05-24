async function fetchTotalEmployees() {
    try {
        const response = await fetch('http://localhost:8000/dashboard/count');
        const data = await response.json();
        document.getElementById('total-employees').textContent = data.total;
    } catch (error) {
        console.error("Gagal ambil data total employee:", error);
    }
}
fetchTotalEmployees()
async function fetchTodayAttendance() {
    try {
        const res = await fetch('http://localhost:8000/dashboard/today_rate');
        const data = await res.json();
        document.getElementById('today-attendance').textContent = `${data.percentage}%`;
    } catch (error) {
        console.error("Error fetching today's attendance:", error);
    }
}
fetchTodayAttendance()

async function fetchPendingPermissions() {
    try {
        const res = await fetch('http://localhost:8000/dashboard/pending_list');
        const data = await res.json();
        document.getElementById('pending-permissions').textContent = data.pending;
    } catch (error) {
        console.error("Error fetching pending permissions:", error);
    }
}
fetchPendingPermissions()