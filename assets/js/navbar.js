async function loadNavbarProfile(userId) {
  try {
    const response = await fetch(`http://localhost:8000/profile/${userId}`);
    if (!response.ok) throw new Error('User profile not found');

    const profile = await response.json();

    // Set Avatar (Navbar and Dropdown)
    const avatarUrl = profile.image_filename
      ? `http://localhost:8000/static/images/${profile.image_filename}`
      : '../assets/img/avatars/default.png';

    document.getElementById('navbarProfileAvatar').src = avatarUrl;
    document.getElementById('dropdownProfileAvatar').src = avatarUrl;

    // Set Name and Role/Position
    document.getElementById('navbarUsername').innerText = profile.username;
    document.getElementById('navbarEmail').innerText = profile.email;

  } catch (error) {
    console.error("Failed to load navbar profile:", error);
    alert('Failed to load profile. Please log in again.');
    window.location.href = "login.html";
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const userId = sessionStorage.getItem('user_id');
  if (userId) {
    loadNavbarProfile(userId);
  } else {
    alert('Please login first');
    window.location.href = "login.html";
  }
});