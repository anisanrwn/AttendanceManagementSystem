document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('loginForm');
    const otpForm = document.getElementById('otpForm');
    const resendOtpButton = document.getElementById('resendOtp');
    let countdownInterval;
    
    // Fungsi untuk menampilkan pesan error/alert
    function showAlert(message, type = 'error') {
        alert(message); // Sebaiknya ganti dengan tampilan alert yang lebih baik
    }
    
    // Fungsi untuk menangani countdown OTP
    function startCountdown() {
        const countdownElement = document.getElementById('countdown');
        let timeLeft = 300; // 5 menit dalam detik
        
        // Clear interval sebelumnya jika ada
        if (countdownInterval) {
            clearInterval(countdownInterval);
        }
        
        function updateCountdown() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            
            countdownElement.textContent = 
                `Kode berlaku untuk: ${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                clearInterval(countdownInterval);
                countdownElement.textContent = 'Kode telah kedaluwarsa. Silakan kirim ulang.';
            } else {
                timeLeft--;
            }
        }
        
        // Update countdown setiap detik
        updateCountdown();
        countdownInterval = setInterval(updateCountdown, 1000);
    }
    
    // Form Login
    loginForm.addEventListener('submit', async function (event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);
        
        try {
            const response = await fetch("http://127.0.0.1:8000/login/login", {
                method: "POST",
                body: formData,
            });
            
            const data = await response.json();
            
            if (!response.ok) {
                showAlert(data.detail || "Login failed, please try again");
                return;
            }
            
            // Cek apakah perlu verifikasi OTP
            if (data.status === "otp_required") {
                // Simpan email untuk digunakan dalam verifikasi OTP
                document.getElementById('otpEmail').value = formData.get('email');
                
                // Tampilkan form OTP dan sembunyikan form login
                loginForm.classList.add('hidden');
                otpForm.classList.remove('hidden');
                
                // Fokus pada input OTP
                document.getElementById('otp').focus();
                
                // Mulai countdown
                startCountdown();
                
                return;
            }
            
            // Jika tidak perlu OTP (meskipun seharusnya selalu perlu)
            handleSuccessfulLogin(data);
            
        } catch (error) {
            showAlert("An error occurred: " + error.message);
        }
    });
    
    // Form OTP
    otpForm.addEventListener('submit', async function (event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);
        
        try {
            const response = await fetch("http://127.0.0.1:8000/login/verify-otp", {
                method: "POST",
                body: formData,
            });
            
            if (!response.ok) {
                const errorData = await response.json();
                showAlert(errorData.detail || "Verifikasi gagal, silakan coba lagi");
                return;
            }
            
            const user = await response.json();
            handleSuccessfulLogin(user);
            
        } catch (error) {
            showAlert("An error occurred: " + error.message);
        }
    });
    
    // Tombol Kirim Ulang OTP
    resendOtpButton.addEventListener('click', async function() {
        const email = document.getElementById('otpEmail').value;
        
        if (!email) {
            showAlert("Email tidak valid");
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
                showAlert(errorData.detail || "Gagal mengirim ulang OTP");
                return;
            }
            
            const data = await response.json();
            showAlert(data.message || "OTP baru telah dikirim", "success");
            
            // Reset countdown
            startCountdown();
            
        } catch (error) {
            showAlert("An error occurred: " + error.message);
        }
    });
    
    // Format input OTP - hanya angka
    const otpInput = document.getElementById('otp');
    otpInput.addEventListener('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
    
    // Auto-submit setelah 6 digit dimasukkan
    otpInput.addEventListener('keyup', function(e) {
        if (this.value.length === 6) {
            otpForm.dispatchEvent(new Event('submit'));
        }
    });
    
    // Fungsi untuk menangani login sukses
    function handleSuccessfulLogin(user) {
        console.log("Login success:", user);
        
        const roleNames = user.roles.map(role => role.roles_name);
        const userId = user.user_id;
        const employeeId = user.employee_id;
        
        // Simpan ke sessionStorage
        sessionStorage.setItem("user_id", userId);
        sessionStorage.setItem("employee_id", employeeId);
        
        if (roleNames.includes("Super Admin") || roleNames.includes("Admin")) {
            window.location.href = `/html/dashboardsuperadmin.html`;
        } else if (roleNames.includes("Employee")) {
            window.location.href = `/html/index.html`;
        } else {
            showAlert("Role tidak dikenali");
        }
    }
});

function handleSuccessfulLogin(user) {
    // Simpan data lengkap
    sessionStorage.setItem("userData", JSON.stringify(user));
    
    // Simpan flag individual untuk redundansi
    const roleNames = user.roles.map(role => role.roles_name);
    sessionStorage.setItem("isAdmin", roleNames.includes("Admin") ? "true" : "false"); 
    sessionStorage.setItem("isSuperAdmin", roleNames.includes("Super Admin") ? "true" : "false");

}
