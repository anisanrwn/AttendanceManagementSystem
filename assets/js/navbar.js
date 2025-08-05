async function loadNavbarProfile(userId) {
  try {
    const response = await fetch(`http://localhost:8000/profile/${userId}`);
    if (!response.ok) throw new Error('User profile not found');

    const profile = await response.json();

    const avatarUrl = profile.image_filename
      ? `http://localhost:8000/static/images/${profile.image_filename}`
      : '../assets/img/avatars/default.png';

    document.getElementById('navbarProfileAvatar').src = avatarUrl;
    document.getElementById('dropdownProfileAvatar').src = avatarUrl;

  
    document.getElementById('navbarUsername').innerText = profile.username;
    document.getElementById('navbarEmail').innerText = profile.email;

  } catch (error) {
    console.error("Failed to load navbar profile:", error);
    Swal.fire({
      icon: 'error',
      title: 'Failed to Load Profile',
      text: 'Unable to load user profile. Please log in again.',
      confirmButtonText: 'OK'
    }).then(() => {
      window.location.href = "login.html";
    });
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const userId = sessionStorage.getItem('user_id');
  if (userId) {
    loadNavbarProfile(userId);
  } else {
    Swal.fire({
      icon: 'warning',
      title: 'Not Logged In',
      text: 'Please log in to continue.',
      confirmButtonText: 'Login'
    }).then(() => {
      window.location.href = "login.html";
    });
  }
});
