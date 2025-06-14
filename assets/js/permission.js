document.addEventListener('DOMContentLoaded', function () {
    const permissionForm = document.getElementById('permissionForm');

    // API Configuration
    const apiBaseUrl = 'http://127.0.0.1:8000';

    // Set tanggal request otomatis ke hari ini
    document.getElementById('request_date').value = new Date().toISOString().split('T')[0];

    // --- SweetAlert2 Helpers ---
    function showSuccessPopup(message = "Berhasil!") {
        Swal.fire({
            icon: 'success',
            title: message,
            timer: 1800,
            showConfirmButton: false,
            // posisi default Swal di tengah
        });
    }

    function showErrorPopup(message = "Terjadi kesalahan!") {
        Swal.fire({
            icon: 'error',
            title: message,
            showConfirmButton: true,
            // posisi default Swal di tengah
        });
    }

    // --- Auth Helpers ---
    async function getUserId() {
        const token = localStorage.getItem('token');
        if (!token) {
            redirectToLogin();
            return null;
        }

        try {
            const response = await authFetch(`${apiBaseUrl}/login/auth/check`);
            if (!response || !response.ok) return null;
            const data = await response.json();
            return data.user_id;
        } catch (error) {
            console.error('Auth check failed:', error);
            return null;
        }
    }

    async function refreshToken() {
        const refreshToken = localStorage.getItem('refreshToken');
        if (!refreshToken) {
            redirectToLogin();
            return null;
        }

        try {
            const response = await fetch(`${apiBaseUrl}/login/refresh-token`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ refresh_token: refreshToken })
            });

            if (response.ok) {
                const { access_token } = await response.json();
                localStorage.setItem('token', access_token);
                return access_token;
            }

            throw new Error('Refresh failed');
        } catch (error) {
            console.error('Token refresh failed:', error);
            redirectToLogin();
            return null;
        }
    }

    async function authFetch(url, options = {}) {
        try {
            const token = localStorage.getItem('token');
            const headers = {
                'Content-Type': 'application/json',
                ...options.headers
            };

            if (token) {
                headers['Authorization'] = `Bearer ${token}`;
            }

            let response = await fetch(url, { ...options, headers });

            if (response.status === 401) {
                const newToken = await refreshToken();
                if (newToken) {
                    headers['Authorization'] = `Bearer ${newToken}`;
                    response = await fetch(url, { ...options, headers });
                } else {
                    return null;
                }
            }

            return response;
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    }

    function redirectToLogin() {
        window.location.href = '/Login.html'; // Sesuaikan dengan halaman login kamu
    }

    // Event listener untuk form submission
    permissionForm.addEventListener('submit', async function (e) {
        e.preventDefault();

        try {
            const userId = await getUserId();
            if (!userId) throw new Error('Gagal mengambil user ID');

            // Ambil data dari form
            const formData = {
                employee_id: parseInt(userId),
                permission_type: document.getElementById('permission_type').value,
                request_date: document.getElementById('request_date').value,
                start_date: document.getElementById('start_date').value,
                end_date: document.getElementById('end_date').value,
                reason: document.getElementById('reason').value,
                permission_status: "Pending"
            };

            // Validasi
            if (!formData.start_date || !formData.end_date || !formData.permission_type || !formData.reason) {
                throw new Error('Semua field harus diisi!');
            }

            if (new Date(formData.start_date) > new Date(formData.end_date)) {
                throw new Error('Tanggal mulai tidak boleh lebih besar dari tanggal selesai!');
            }

            const response = await authFetch(`${apiBaseUrl}/permissions/request`, {
                method: "POST",
                body: JSON.stringify(formData)
            });

            if (!response || !response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.detail || 'Gagal mengirim permohonan');
            }

            const result = await response.json();

            showSuccessPopup(result.message || 'Permohonan izin berhasil dikirim!');
            permissionForm.reset();

        } catch (error) {
            console.error("Error:", error);
            showErrorPopup(error.message || 'Terjadi kesalahan saat mengirim permohonan');
        }
    });
});
