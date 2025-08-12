document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded'); // Debug log
    
    // Modal functions
    window.openForgotPasswordModal = function() {
        console.log('Opening modal...'); // Debug log
        const modal = document.getElementById('forgotPasswordModal');
        if (modal) {
            modal.style.display = 'block';
            const emailInput = document.getElementById('resetEmail');
            if (emailInput) {
                setTimeout(() => emailInput.focus(), 100);
            }
        } else {
            console.error('Modal not found');
        }
    }
    
    window.closeForgotPasswordModal = function() {
        console.log('Closing modal...'); // Debug log
        const modal = document.getElementById('forgotPasswordModal');
        if (modal) {
            modal.style.display = 'none';
            const form = document.getElementById('forgotPasswordForm');
            const messageDiv = document.getElementById('resetMessage');
            if (form) form.reset();
            if (messageDiv) messageDiv.innerHTML = '';
            
            // Reset email input styling
            const emailInput = document.getElementById('resetEmail');
            if (emailInput) {
                emailInput.style.borderColor = '#ddd';
            }
        }
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('forgotPasswordModal');
        if (event.target == modal) {
            closeForgotPasswordModal();
        }
    }
    
    // ✅ ENHANCED: Handle forgot password form submission with real-time validation
    const forgotForm = document.getElementById('forgotPasswordForm');
    if (forgotForm) {
        const emailInput = document.getElementById('resetEmail');
        const submitBtn = forgotForm.querySelector('button[type="submit"]');
        const messageDiv = document.getElementById('resetMessage');
        
        // Real-time email validation
        if (emailInput) {
            emailInput.addEventListener('input', function() {
                const email = this.value.trim();
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                
                if (email && !emailRegex.test(email)) {
                    this.style.borderColor = '#dc3545';
                    this.style.boxShadow = '0 0 5px rgba(220, 53, 69, 0.3)';
                    if (submitBtn) submitBtn.disabled = true;
                    showMessage('Please enter a valid email address', 'error');
                } else if (email && emailRegex.test(email)) {
                    this.style.borderColor = '#28a745';
                    this.style.boxShadow = '0 0 5px rgba(40, 167, 69, 0.3)';
                    if (submitBtn) submitBtn.disabled = false;
                    hideMessage();
                } else {
                    this.style.borderColor = '#ddd';
                    this.style.boxShadow = 'none';
                    if (submitBtn) submitBtn.disabled = false;
                    hideMessage();
                }
            });
            
            // Validate on blur
            emailInput.addEventListener('blur', function() {
                const email = this.value.trim();
                if (email) {
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email)) {
                        showMessage('Please enter a valid email format (example@domain.com)', 'error');
                    }
                }
            });
        }
        
        forgotForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const email = formData.get('email')?.trim();
            const originalText = submitBtn?.textContent || 'Send Reset Link';
            
            // Validate email
            if (!email) {
                showMessage('Please enter your email address', 'error');
                emailInput?.focus();
                return;
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showMessage('Please enter a valid email address', 'error');
                emailInput?.focus();
                return;
            }
            
            // Clear previous messages
            hideMessage();
            
            try {
                console.log('🚀 Sending forgot password request for:', email);
                
                // Show loading state
                if (submitBtn) {
                    submitBtn.textContent = 'Sending...';
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = '0.7';
                }
                
                // ✅ FIXED: Real API call with proper timeout and error handling
                const controller = new AbortController();
                const timeoutId = setTimeout(() => controller.abort(), 30000); // 30 second timeout
                
                const response = await fetch('http://localhost:8000/login/forgot-password', {
                    method: 'POST',
                    body: formData,
                    signal: controller.signal
                });
                
                clearTimeout(timeoutId);
                console.log('📡 Response status:', response.status);
                
                let result;
                try {
                    result = await response.json();
                } catch (jsonError) {
                    console.error('JSON parse error:', jsonError);
                    result = { detail: 'Invalid server response' };
                }
                
                console.log('📋 Response data:', result);
                
                if (response.ok) {
                    // ✅ Success - Email sent
                    const successMessage = result.message || 'Password reset link has been sent to your email. Please check your inbox and spam folder.';
                    showMessage(successMessage, 'success');
                    
                    // Clear and reset form
                    emailInput.value = '';
                    emailInput.style.borderColor = '#ddd';
                    emailInput.style.boxShadow = 'none';
                    
                    console.log('✅ Forgot password request successful');
                    
                    // Auto close modal after 4 seconds
                    setTimeout(() => {
                        closeForgotPasswordModal();
                    }, 4000);
                    
                } else {
                    // ❌ Error response
                    console.error('❌ API Error:', result);
                    
                    let errorMessage = 'An error occurred. Please try again.';
                    
                    // Handle different HTTP status codes
                    switch (response.status) {
                        case 400:
                            errorMessage = result.detail || 'Invalid request. Please check your input.';
                            break;
                        case 404:
                            errorMessage = 'If this email exists in our system, a reset link will be sent.';
                            // For security, we don't reveal if email exists or not
                            break;
                        case 429:
                            errorMessage = 'Too many requests. Please wait a few minutes before trying again.';
                            break;
                        case 500:
                        case 502:
                        case 503:
                            errorMessage = 'Server error. Please try again in a few minutes.';
                            break;
                        default:
                            if (result.detail) {
                                errorMessage = result.detail;
                            }
                    }
                    
                    showMessage(errorMessage, 'error');
                }
                
            } catch (error) {
                console.error('🔥 Network Error:', error);
                
                let errorMessage = 'Network error. Please check your connection and try again.';
                
                if (error.name === 'AbortError') {
                    errorMessage = 'Request timeout. Please try again.';
                } else if (error.name === 'TypeError' && error.message.includes('fetch')) {
                    errorMessage = 'Cannot connect to server. Please check if the server is running.';
                } else if (error.message.includes('Failed to fetch')) {
                    errorMessage = 'Connection failed. Please check your internet connection.';
                }
                
                showMessage(errorMessage, 'error');
            } finally {
                // Reset button state
                if (submitBtn) {
                    submitBtn.textContent = originalText;
                    submitBtn.disabled = false;
                    submitBtn.style.opacity = '1';
                }
            }
        });
        
        function showMessage(message, type) {
            if (!messageDiv) return;
            
            const isSuccess = type === 'success';
            messageDiv.innerHTML = `
                <div class="${type}-message" style="
                    color: ${isSuccess ? '#155724' : '#721c24'};
                    background-color: ${isSuccess ? '#d4edda' : '#f8d7da'};
                    border: 1px solid ${isSuccess ? '#c3e6cb' : '#f5c6cb'};
                    padding: 15px;
                    border-radius: 5px;
                    margin-top: 15px;
                    font-size: 14px;
                    line-height: 1.5;
                    animation: slideIn 0.3s ease-out;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                ">
                    <div style="display: flex; align-items: center;">
                        <span style="margin-right: 8px; font-size: 16px;">
                            ${isSuccess ? '✅' : '❌'}
                        </span>
                        <span>${message}</span>
                    </div>
                </div>
            `;
            
            // Add CSS animation if not already present
            if (!document.querySelector('#modalAnimationStyle')) {
                const style = document.createElement('style');
                style.id = 'modalAnimationStyle';
                style.textContent = `
                    @keyframes slideIn {
                        from { opacity: 0; transform: translateY(-10px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);
            }
        }
        
        function hideMessage() {
            if (messageDiv) {
                messageDiv.innerHTML = '';
            }
        }
    }
    
    // Handle login form (existing functionality continues...)
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            // Add your existing login logic here
            console.log('Login form submitted');
        });
    }
});

// ✅ EXISTING LOGIN CODE (unchanged - keeping all the original MFA and lockout logic)
document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('loginForm');
    let currentStep = 1; // Track current step (1: login, 2: MFA)
    let userEmail = ''; // Store email for MFA steps

    // Alert SweetAlert
    function showAlert(message, type = 'error') {
        Swal.fire({
            icon: type,
            title: type === 'success' ? 'Success' : 'Error',
            text: message,
        });
    }

    // Show MFA Setup Required Modal
    function showMFASetupModal() {
        Swal.fire({
            icon: 'warning',
            title: 'Security Enhancement Required',
            text: 'Due to previous failed login attempts, you need to set up Multi-Factor Authentication for account security.',
            showCancelButton: false,
            confirmButtonText: 'Setup MFA Now',
            allowOutsideClick: false
        }).then((result) => {
            if (result.isConfirmed) {
                sessionStorage.setItem('setup_email', userEmail);
                window.location.href = '/html/setup-mfa.html';
            }
        });
    }

    // Show MFA Input Step
    function showMFAStep() {
        document.getElementById('step1').style.display = 'none';
        document.getElementById('step2').style.display = 'block';
        document.querySelector('button[type="submit"]').textContent = 'Verify Code';
        document.querySelector('.card-body h4').textContent = 'Enter MFA Code';
        document.querySelector('.card-body p').textContent = 'Enter the 6-digit code from Google Authenticator';
        
        // Focus on MFA input
        document.getElementById('otp').focus();
        currentStep = 2;
    }

    // Reset to login step
    function resetToLoginStep() {
        document.getElementById('step1').style.display = 'block';
        document.getElementById('step2').style.display = 'none';
        document.querySelector('button[type="submit"]').textContent = 'Sign in';
        document.querySelector('.card-body h4').textContent = 'Welcome to Attendance System Management!';
        document.querySelector('.card-body p').textContent = 'Please sign-in';
        currentStep = 1;
        userEmail = '';
        
        // Clear MFA input
        document.getElementById('otp').value = '';
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

        // Clear any temporary storage
        sessionStorage.removeItem('login_email');
        sessionStorage.removeItem('setup_email');

        if (roleNames.includes("Super Admin") || roleNames.includes("Admin")) {
            window.location.href = `/html/admin_dashboard.html`;
        } else if (roleNames.includes("Employee")) {
            window.location.href = `/html/employee_dashboard.html`;
        } else {
            showAlert("Role not recognized");
            window.location.href = "/html/login.html";
        }
    }

    // Handle regular login (Step 1)
    async function handleRegularLogin(formData) {
        try {
            const response = await fetch("http://127.0.0.1:8000/login/login", {
                method: "POST",
                body: formData,
            });

            const data = await response.json().catch(() => ({}));

            // 🔧 FIXED: Handle different types of account locked
            if (response.status === 423) {
                // Check if it's permanent lock or existing lockout
                if (typeof data.detail === 'string') {
                    // Permanent lock (15+ attempts) - redirect to verify page
                    if (data.detail.includes("permanently locked") || data.detail.includes("check your email")) {
                        sessionStorage.setItem("user_email", formData.get('email'));
                        window.location.href = "../html/verifyacc.html";
                        return;
                    }
                }
                
                // Existing lockout (user trying to login while still locked) - redirect to verify page
                if (typeof data.detail === 'object' && data.detail.type === 'account_locked') {
                    if (data.detail.message && data.detail.message.includes("currently locked")) {
                        sessionStorage.setItem("user_email", formData.get('email'));
                        window.location.href = "../html/verifyacc.html";
                        return;
                    }
                }
                
                // Fallback for any other 423 response - redirect
                sessionStorage.setItem("user_email", formData.get('email'));
                window.location.href = "../html/verifyacc.html";
                return;
            }

            // 🔧 FIXED: Handle temporary lockout (5 & 10 attempts) - Show pop-up
            if (response.status === 401) {
                // Check if it's a structured lockout response (5 or 10 attempts)
                if (typeof data.detail === 'object' && data.detail.type === 'account_locked') {
                    const attempts = data.detail.attempts;
                    const duration = data.detail.duration;
                    const lockedUntil = data.detail.locked_until;
                    
                    let lockoutMessage = `Account locked due to ${attempts} failed login attempts.\n`;
                    lockoutMessage += `Locked until: ${lockedUntil}\n`;
                    lockoutMessage += `Duration: ${duration}`;
                    
                    showAlert(lockoutMessage, 'warning');
                    return;
                }
                
                // Regular 401 error
                const errorMessage = getHttpErrorMessage(response.status, data.detail);
                showAlert(errorMessage, 'error');

                if (data.detail === "Your role is currently locked. Please contact an administrator.") {
                    window.location.href = "../html/undermaintenance.html";
                }
                return;
            }

            if (!response.ok) {
                const errorMessage = getHttpErrorMessage(response.status, data.detail);
                showAlert(errorMessage, 'error');

                if (data.detail === "Your role is currently locked. Please contact an administrator.") {
                    window.location.href = "../html/undermaintenance.html";
                }
                return;
            }

            // Handle different response types
            if (data.status === 'mfa_setup_required') {
                showMFASetupModal();
            } else if (data.status === 'mfa_required') {
                userEmail = formData.get('email');
                sessionStorage.setItem('login_email', userEmail);
                showMFAStep();
            } else {
                // Direct login success (no MFA)
                handleSuccessfulLogin(data);
            }

        } catch (error) {
            console.error('Login error:', error);
            showAlert('Network error occurred', 'error');
        }
    }

    // Handle MFA verification (Step 2)
    async function handleMFAVerification(mfaCode) {
        try {
            const formData = new FormData();
            formData.append('email', userEmail);
            formData.append('mfa_code', mfaCode);

            const response = await fetch("http://127.0.0.1:8000/login/verify-mfa", {
                method: "POST",
                body: formData,
            });

            const data = await response.json().catch(() => ({}));

            if (!response.ok) {
                const errorMessage = data.detail || 'Invalid MFA code';
                showAlert(errorMessage, 'error');
                
                // Clear MFA input for retry
                document.getElementById('otp').value = '';
                document.getElementById('otp').focus();
                return;
            }

            // MFA verification successful
            handleSuccessfulLogin(data);

        } catch (error) {
            console.error('MFA verification error:', error);
            showAlert('Network error occurred', 'error');
        }
    }

    // Main form submission handler
    loginForm.addEventListener('submit', async function (event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);

        // Disable submit button during processing
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.textContent;
        submitBtn.disabled = true;
        submitBtn.textContent = 'Processing...';

        try {
            if (currentStep === 1) {
                // Regular login step
                userEmail = formData.get('email');
                await handleRegularLogin(formData);
            } else if (currentStep === 2) {
                // MFA verification step
                const mfaCode = formData.get('otp');
                if (!mfaCode || mfaCode.length !== 6) {
                    showAlert('Please enter a valid 6-digit code', 'error');
                    return;
                }
                await handleMFAVerification(mfaCode);
            }
        } finally {
            // Re-enable submit button
            submitBtn.disabled = false;
            submitBtn.textContent = originalText;
        }
    });

    // Auto-submit when MFA code is 6 digits
    document.getElementById('otp').addEventListener('input', function() {
        // Only allow numbers
        this.value = this.value.replace(/[^0-9]/g, '');
        
        // Auto-submit when 6 digits entered
        if (this.value.length === 6) {
            setTimeout(() => {
                loginForm.dispatchEvent(new Event('submit'));
            }, 500); // Small delay for better UX
        }
    });

    // Add back button functionality for MFA step
    function addBackButton() {
        if (currentStep === 2) {
            const existingBackBtn = document.getElementById('back-to-login');
            if (!existingBackBtn) {
                const backBtn = document.createElement('button');
                backBtn.type = 'button';
                backBtn.className = 'btn btn-secondary d-grid w-100 mt-2';
                backBtn.id = 'back-to-login';
                backBtn.textContent = 'Back to Login';
                backBtn.onclick = resetToLoginStep;
                
                document.querySelector('.mb-3:last-child').appendChild(backBtn);
            }
        }
    }

    // Reset form when going back
    function resetToLoginStep() {
        document.getElementById('step1').style.display = 'block';
        document.getElementById('step2').style.display = 'none';
        document.querySelector('button[type="submit"]').textContent = 'Sign in';
        document.querySelector('.card-body h4').textContent = 'Welcome to Attendance System Management!';
        document.querySelector('.card-body p').textContent = 'Please sign-in';
        currentStep = 1;
        userEmail = '';
        
        // Clear form
        document.getElementById('otp').value = '';
        document.getElementById('email').value = '';
        document.getElementById('password').value = '';
        
        // Remove back button
        const backBtn = document.getElementById('back-to-login');
        if (backBtn) {
            backBtn.remove();
        }
    }

    // Modify showMFAStep to include back button
    function showMFAStep() {
        document.getElementById('step1').style.display = 'none';
        document.getElementById('step2').style.display = 'block';
        document.querySelector('button[type="submit"]').textContent = 'Verify Code';
        document.querySelector('.card-body h4').textContent = 'Enter MFA Code';
        document.querySelector('.card-body p').textContent = 'Enter the 6-digit code from Google Authenticator';
        
        // Focus on MFA input
        document.getElementById('otp').focus();
        currentStep = 2;
        
        // Add back button
        addBackButton();
    }

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
                "User not found": "User not found.",
                "Notification not found or you don't have permission": "Notification not found or access denied.",
            },
            423: {
                default: "Your account has been permanently locked.",
                "User not found": "User not found.",
                "Notification not found or you don't have permission": "Notification not found or access denied.",
            },
            default: "An error occurred. Please try again later."
        };

        const category = httpExceptions[statusCode] || {};
        return category[detailMessage] || category.default || httpExceptions.default;
    }
});