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
            window.location.href = `/html/dashboardsuperadmin.html`;
        } else if (roleNames.includes("Employee")) {
            window.location.href = `/html/index.html`;
        } else {
            showAlert("Role not recognized");
            window.location.href = "/login/login";
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
                    window.location.href = "../html/pages-misc-under-maintenance.html";
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

    // Fungsi pesan error HTTP
    function getHttpErrorMessage(statusCode, detailMessage = "") {
        const httpExceptions = {
            401: {
                default: "Unauthorized access. Please check your credentials.",
                "Email atau password salah.": "Email atau password salah.",
                "Invalid token type": "Token tidak valid.",
                "Invalid refresh token": "Refresh token tidak valid.",
                "Refresh token expired": "Sesi Anda telah habis. Silakan login ulang.",
            },
            403: {
                default: "Your role is currently locked. Please contact an administrator.",
                "Anda tidak memiliki akses.": "Peran Anda dikunci. Hubungi admin.",
                "IP Anda telah diblokir karena terlalu banyak percobaan login yang gagal.": "IP Anda diblokir karena terlalu banyak gagal login.",
                "Akun dikunci. Silakan coba lagi setelah": "Akun dikunci sementara.",
            },
            404: {
                default: "Data tidak ditemukan.",
                "User  not found": "Pengguna tidak ditemukan.",
                "Notification not found or you don't have permission": "Notifikasi tidak ditemukan atau akses ditolak.",
            },
            default: "Terjadi kesalahan. Silakan coba lagi nanti."
        };

        const category = httpExceptions[statusCode] || {};
        return category[detailMessage] || category.default || httpExceptions.default;
    }
});
