document.addEventListener("DOMContentLoaded", function () {
    const logoutButtons = document.querySelectorAll(".logout-button");

    logoutButtons.forEach(button => {
      button.addEventListener("click", () => {
        localStorage.removeItem("token");
        localStorage.removeItem("refreshToken");
        sessionStorage.clear();
        window.location.href = "/html/login.html";
      });
    });
  });