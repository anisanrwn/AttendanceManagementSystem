// Countdown timer
function updateCountdown(endTime) {
    const now = new Date().getTime();
    const distance = new Date(endTime).getTime() - now;
    
    if (distance < 0) {
        document.getElementById('countdown').innerHTML = "Maintenance should be over now. Please try refreshing the page.";
        return;
    }
    
    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);
    
    document.getElementById('countdown').innerHTML = `Estimated time remaining: ${hours}h ${minutes}m ${seconds}s`;
}
    
// Get lock end time from server
fetch("http://localhost:8000/lock/check-status")
    .then(response => response.json())
    .then(data => {
        if (data.locked) {
            setInterval(() => updateCountdown(data.end_time), 1000);
        }
    })
    .catch(error => {
        console.error("Error fetching lock status:", error);
    });

    localStorage.setItem('token', data.access_token);
    localStorage.setItem('refreshToken', data.refresh_token);