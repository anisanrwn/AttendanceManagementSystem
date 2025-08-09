document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('loginForm');

    // Alert SweetAlert
    function showAlert(message, type = 'error') {
        Swal.fire({
            icon: type,
            title: type === 'success' ? 'Success' : 'Error',
            text: message,
        });
    }

    // Fungsi untuk menangani login sukses
    function handleSuccessfulLogin(user) {
        console.log("Login success:", user);
        localStorage.setItem('token', user.access_token);
        localStorage.setItem('refreshToken', user.refresh_token);
        sessionStorage.setItem("user_id", user.user_id);
        sessionStorage.setItem("employee_id", user.employee_id);
        sessionStorage.setItem("user_email", user.email);
        sessionStorage.setItem("userData", JSON.stringify(user));
        
        const roleNames = user.roles.map(role => role.roles_name);
        sessionStorage.setItem("isAdmin", roleNames.includes("Admin") ? "true" : "false"); 
        sessionStorage.setItem("isSuperAdmin", roleNames.includes("Super Admin") ? "true" : "false");

        if (roleNames.includes("Super Admin") || roleNames.includes("Admin")) {
            window.location.href = `/html/admin_dashboard.html`;
        } else if (roleNames.includes("Employee")) {
            window.location.href = `/html/employee_dashboard.html`;
        } else {
            showAlert("Role not recognized");
            window.location.href = "/html/login.html";
        }
    }

    loginForm.addEventListener('submit', async function (event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);

        try {
            const response = await fetch("http://127.0.0.1:8000/login/login", {
                method: "POST",
                body: formData,
            });

            const data = await response.json().catch(() => ({}));

            if (response.status === 423) {
                sessionStorage.setItem("user_email", formData.get('email'));
                window.location.href = "../html/verifyacc.html";
                return;
            }
            if (!response.ok) {
                const errorMessage = data.detail || "An unexpected error occurred.";
                showAlert(errorMessage, 'error');

                if (data.detail === "Your role is currently locked. Please contact an administrator.") {
                    window.location.href = "../html/undermaintenance.html";
                }
                return;
            }

            // Login sukses langsung
            handleSuccessfulLogin(data);

        } catch (error) {
            console.error("Login error:", error);
            showAlert("An error occurred during login. Please try again.", 'error');
        }
    });

    function getHttpErrorMessage(statusCode, detailMessage = "") {
        const httpExceptions = {
            401: {
                default: "Unauthorized access. Please check your credentials.",
                "Unauthorized access. Please check your credentials.": "Unauthorized access. Please check your credentials.",
                "Invalid token type": "Invalid token type.",
                "Invalid refresh token": "Invalid refresh token.",
                "Refresh token expired": "Your session has expired. Please log in again.",
            },
            403: {
                default: "Your role is currently locked. Please contact an administrator.",
                "You do not have access.": "You do not have access.",
                "Your IP has been blocked due to too many failed login attempts.": "Your IP has been blocked due to too many failed login attempts.",
                "Your account is temporarily locked. Please try again later.": "Your account is temporarily locked. Please try again later.",
            },
            404: {
                default: "Data not found.",
                "User  not found": "User not found.",
                "Notification not found or you don't have permission": "Notification not found or access denied.",
            },
             423: {
                default: "Your account has been permanently locked.",
                "User  not found": "User not found.",
                "Notification not found or you don't have permission": "Notification not found or access denied.",
            },
            default: "An error occurred. Please try again later."

        };

        const category = httpExceptions[statusCode] || {};
        return category[detailMessage] || category.default || httpExceptions.default;
    }
});
