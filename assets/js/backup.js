document.getElementById('backupScheduleForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const amount = parseInt(document.getElementById('intervalAmount').value);
    const unit = parseInt(document.getElementById('intervalUnit').value);
    const startTime = document.getElementById('startTime').value;

    if (isNaN(amount) || isNaN(unit) || !startTime) {
      Swal.fire({
        icon: 'warning',
        title: 'Invalid Input',
        text: 'Please fill all fields correctly.'
      });
      return;
    }

    const intervalMinutes = amount * unit;

    fetch('http://localhost:8000/api/save-backup-schedule', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        intervalMinutes: intervalMinutes,
        startTime: startTime
      })
    })
    .then(response => {
      if (!response.ok) throw new Error('Failed to save schedule');
      return response.json();
    })
  .then(data => {
    Swal.fire({
      icon: 'success',
      title: 'Schedule Saved!',
      text: `Backup will run every ${intervalMinutes} minutes.`
    });

    const formattedInterval = formatInterval(intervalMinutes);
    const formattedDate = formatTanggalIndonesia(startTime);
    const displayText = `Every ${formattedInterval}, starting at ${startTime}, beginning on ${formattedDate}`;
    document.getElementById('intervalDisplay').textContent = displayText;
    console.log(`Fetched & applied new interval: ${displayText}`);

    localStorage.setItem('backupScheduleDisplay', displayText);

    document.getElementById('backupScheduleForm').reset();
    document.getElementById('intervalAmount').focus();

  })

    .catch(error => {
      console.error('Error:', error);
      Swal.fire({
        icon: 'error',
        title: 'Oops!',
        text: 'Something went wrong while saving the schedule.'
      });
    });
  });

  function formatInterval(minutes) {
  const units = [
    { label: 'month', value: 43200 },
    { label: 'week', value: 10080 },
    { label: 'day', value: 1440 },
    { label: 'hour', value: 60 },
    { label: 'minutes', value: 1 }
  ];

  for (let unit of units) {
    if (minutes >= unit.value) {
      const count = Math.round(minutes / unit.value);
      return `${count} ${unit.label}${count > 1 ? '' : ''}`;
    }
  }

  return `${minutes} minutes`;
}

function formatTanggalIndonesia(dateString) {
  const date = new Date();
  const [hour, minute] = dateString.split(":");
  date.setHours(hour, minute, 0);

  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];


  const dayName = days[date.getDay()];
  const day = date.getDate();
  const month = months[date.getMonth()];
  const year = date.getFullYear();

  return `${dayName}, ${day} ${month} ${year}`;
}

document.addEventListener('DOMContentLoaded', function () {
  const savedSchedule = localStorage.getItem('backupScheduleDisplay');
  if (savedSchedule) {
    document.getElementById('intervalDisplay').textContent = savedSchedule;
    console.log(`Loaded saved schedule: ${savedSchedule}`);
  }
});
