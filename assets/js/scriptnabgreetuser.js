    document.addEventListener("DOMContentLoaded", function () {
      const userId = sessionStorage.getItem("user_id");
      const employeeId = sessionStorage.getItem("employee_id");
  
      if (userId && employeeId) {
          console.log("User ID:", userId);
          console.log("Employee ID:", employeeId);
          // Gunakan data ini untuk fetch atau menampilkan konten
      } else {
          console.error("User belum login");
          // Redirect ke login jika perlu
          window.location.href = "/login.html";
      }
  });

  document.addEventListener("DOMContentLoaded", function () {
    const userId = sessionStorage.getItem("user_id");
    const employeeId = sessionStorage.getItem("employee_id");

    if (!userId || !employeeId) {
        alert("Session expired or not found. Please login again.");
        window.location.href = "login.html";
        return;
    }

    // Debug: tampilkan user_id di console
    console.log("User ID from session:", userId);
    console.log("Employee ID from session:", employeeId);

    // Misalnya, tampilkan nama user di dashboard
    document.getElementById("welcome-message").textContent = `User #${userId}`;
});