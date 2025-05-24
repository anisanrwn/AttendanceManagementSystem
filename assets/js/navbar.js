async function loadNavbarProfile(employeeId) {
  try {
    const response = await fetch(`http://localhost:8000/profile/${employeeId}`);
    if (!response.ok) throw new Error('Employee profile not found');

    const profile = await response.json();

    // Set Avatar (Navbar and Dropdown)
    const avatarUrl = profile.image_filename
      ? `http://localhost:8000/static/images/${profile.image_filename}`
      : '../assets/img/avatars/default.png';

    document.getElementById('navbarProfileAvatar').src = avatarUrl;
    document.getElementById('dropdownProfileAvatar').src = avatarUrl;

    // Set Name and Role/Position
    const fullName = `${profile.first_name} ${profile.last_name}`;
    document.getElementById('navbarProfileName').innerText = fullName;
    document.getElementById('navbarProfileRole').innerText = profile.position;

  } catch (error) {
    console.error("Failed to load navbar profile:", error);
    alert('Failed to load profile. Please log in again.');
    window.location.href = "login.html";
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const employeeId = sessionStorage.getItem('employee_id');
  if (employeeId) {
    loadNavbarProfile(employeeId);
  } else {
    alert('Please login first');
    window.location.href = "login.html";
  }
});