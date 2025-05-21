document.addEventListener("DOMContentLoaded", function () {
    document.getElementById('loginForm').addEventListener('submit', async function (event) {
        event.preventDefault();

        const form = event.target;
        const formData = new FormData(form);

        try {
            const response = await fetch("http://127.0.0.1:8000/login/login", {
                method: "POST",
                body: formData,
            });

              if (!response.ok) {
                const errorData = await response.json().catch(() => ({ detail: "Unknown error" }));
                if (errorData.detail === "Your role is currently locked. Please contact an administrator.") {
                    // Redirect to the account settings page
                      window.location.href = "../html/pages-misc-under-maintenance.html";
                } else {
                    alert(errorData.detail || "Login failed, please try again");
                }
                return;
            }

            const data = await response.json();
            console.log("Login success:", data);

            // Store tokens in localStorage
            localStorage.setItem('token', data.access_token);
            localStorage.setItem('refreshToken', data.refresh_token);

            // Store user info in sessionStorage
            sessionStorage.setItem("user_id", data.user_id);
            sessionStorage.setItem("employee_id", data.employee_id);
            sessionStorage.setItem("user_email", data.email);

            // Extract role names
            const roleNames = data.roles.map(role => role.roles_name);

            // Redirect based on role
            if (roleNames.includes("Super Admin") || roleNames.includes("Admin")) {
                window.location.href = `/html/dashboardsuperadmin.html`;
            } else if (roleNames.includes("Employee")) {
                window.location.href = `/html/index.html`;
            } else {
                alert("Role not recognized");
                window.location.href = "/login/login";
            }
        } catch (error) {
            console.error("Login error:", error);
            alert("An error occurred during login. Please try again.");
        }
    });
});