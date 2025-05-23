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
                const errorMessage = getHttpErrorMessage(response.status, errorData.detail);

                // Menampilkan SweetAlert untuk kesalahan login
                Swal.fire({
                    icon: 'error',
                    title: 'Login Failed',
                    text: errorMessage,
                });

                if (errorData.detail === "Your role is currently locked. Please contact an administrator.") {
                    // Redirect to the account settings page
                    window.location.href = "../html/pages-misc-under-maintenance.html";
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
                Swal.fire({
                    icon: 'warning',
                    title: 'Role Not Recognized',
                    text: "Role not recognized",
                });
                window.location.href = "/login/login";
            }
        } catch (error) {
            console.error("Login error:", error);
            Swal.fire({
                icon: 'error',
                title: 'An Error Occurred',
                text: "An error occurred during login. Please try again.",
            });
        }
    });
});

// Fungsi untuk mendapatkan pesan kesalahan berdasarkan status dan detail
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
