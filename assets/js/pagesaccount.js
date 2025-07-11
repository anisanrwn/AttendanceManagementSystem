async function loadProfile(employeeId) {
  try {
    const response = await fetch(`http://localhost:8000/profileemployee/${employeeId}`);
    if (!response.ok) throw new Error('Employee profile not found');
    const profile = await response.json();

    document.getElementById('profileName').innerText = profile.first_name;
    document.getElementById('profileLastName').innerText = profile.last_name;
    document.getElementById('profilePosition').innerText = profile.position;
    document.getElementById('profileNRP').innerText = profile.nrp_id;
    document.getElementById('profileEmail').innerText = profile.email;
    document.getElementById('profilePhone').innerText = profile.phone_number;
    document.getElementById('profileDepartment').innerText = profile.department;

    // Load profile image
    const profileAvatar = document.getElementById('profileAvatar');
    if (profile.image_filename) {
      profileAvatar.src = `http://localhost:8000/static/images/${profile.image_filename}`;
    } else {
      profileAvatar.src = '../assets/img/avatars/default.png'; // fallback image
    }

  } catch (error) {
    alert(error.message);
    window.location.href = "login.html";
  }
}

    document.addEventListener('DOMContentLoaded', () => {
      const employeeId = sessionStorage.getItem('employee_id');
      if (employeeId) {
        loadProfile(employeeId);
      } else {
        alert('Please login first');
        window.location.href = "Login.html";
      }
    });

