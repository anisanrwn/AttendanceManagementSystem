document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('loginForm');
    const otpForm = document.getElementById('otpForm');
    const resendOtpButton = document.getElementById('resendOtp');
    const otpInput = document.getElementById('otp');
    let countdownInterval;

    // Alert SweetAlert
    function showAlert(message, type = 'error') {
        Swal.fire({
            icon: type,
            title: type === 'success' ? 'Success' : 'Error',
            text: message,
        });
    }

    function startCountdown() {
        const countdownElement = document.getElementById('countdown');
        let timeLeft = 300;
        if (countdownInterval) clearInterval(countdownInterval);

        function updateCountdown() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            countdownElement.textContent = `Code valid for: ${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            if (timeLeft <= 0) {
                clearInterval(countdownInterval);
                countdownElement.textContent = 'The code has expired. Please resubmit.';
            } else {
                timeLeft--;
            }
        }

        updateCountdown();
        countdownInterval = setInterval(updateCountdown, 1000);
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

            if (!response.ok) {
                const errorMessage = getHttpErrorMessage(response.status, data.detail || "");
                showAlert(errorMessage, 'error');

                if (data.detail === "Your role is currently locked. Please contact an administrator.") {
                    window.location.href = "../html/undermaintenance.html";
                }
                return;
            }

            // Jika butuh OTP
            if (data.status === "otp_required") {
                document.getElementById('otpEmail').value = formData.get('email');
                loginForm.classList.add('hidden');
                otpForm.classList.remove('hidden');
                document.getElementById('otp').focus();
                startCountdown();

            Swal.fire({
                icon: 'success',
                title: 'OTP Sent',
                text: 'An OTP has been sent to your email. Please check your inbox.',
                confirmButtonColor: '#3085d6'
            });

            return;
        }

            // Jika login sukses langsung
            handleSuccessfulLogin(data);

        } catch (error) {
            console.error("Login error:", error);
            showAlert("An error occurred during login. Please try again.", 'error');
        }
    });

    otpForm.addEventListener('submit', async function (event) {
        event.preventDefault();
        const formData = new FormData(otpForm);

        try {
            const response = await fetch("http://127.0.0.1:8000/login/verify-otp", {
                method: "POST",
                body: formData,
            });

            if (!response.ok) {
                const errorData = await response.json();
                showAlert(errorData.detail || "Verification failed, please try again");
                return;
            }

            const user = await response.json();
            handleSuccessfulLogin(user);

        } catch (error) {
            showAlert("An error occurred: " + error.message);
        }
    });

    resendOtpButton.addEventListener('click', async function() {
        const email = document.getElementById('otpEmail').value;
        if (!email) {
            showAlert("Email not valid");
            return;
        }

        try {
            const formData = new FormData();
            formData.append('email', email);

            const response = await fetch("http://127.0.0.1:8000/login/resend-otp", {
                method: "POST",
                body: formData,
            });

            if (!response.ok) {
                const errorData = await response.json();
                showAlert(errorData.detail || "Failed to resend OTP");
                return;
            }

            const data = await response.json();
            showAlert(data.message || "The new OTP has been sent", "success");
            startCountdown();

        } catch (error) {
            showAlert("An error occurred: " + error.message);
        }
    });

    otpInput.addEventListener('input', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    otpInput.addEventListener('keyup', function () {
        if (this.value.length === 6) {
            otpForm.dispatchEvent(new Event('submit'));
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
            default: "An error occurred. Please try again later."

        };

        const category = httpExceptions[statusCode] || {};
        return category[detailMessage] || category.default || httpExceptions.default;
    }
});
