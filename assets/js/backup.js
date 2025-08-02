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