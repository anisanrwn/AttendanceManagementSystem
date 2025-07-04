document.addEventListener('DOMContentLoaded', function () {
    // Konfigurasi dasar
    const config = {
        apiBaseUrl: 'http://127.0.0.1:8000',
        maxNotifications: 20,
        pollingInterval: 30000 // 30 detik
    };

    // Elemen UI
    const notificationDropdown = document.querySelector('.dropdown-menu[aria-labelledby="notification-area"]');
    const notificationBadge = document.getElementById('notification-badge');

    // Ambil user ID dari token
    async function getUserId() {
        const token = localStorage.getItem('token');
        if (!token) {
            redirectToLogin();
            return null;
        }

        try {
            const response = await authFetch(`${config.apiBaseUrl}/login/auth/check`);
            if (!response) return null;

            const data = await response.json();
            return data.user_id;
        } catch (error) {
            return null;
        }
    }

    // Refresh token jika expired
    async function refreshToken() {
        const refreshToken = localStorage.getItem('refreshToken');
        if (!refreshToken) {
            redirectToLogin();
            return null;
        }

        try {
            const response = await fetch(`${config.apiBaseUrl}/login/refresh-token`, {
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
            return null;
        }
    }

    async function loadNotifications() {
        try {
            notificationDropdown.innerHTML = '<li><a class="dropdown-item text-center py-3">Loading notifications...</a></li>';

            const userId = await getUserId();
            if (!userId) return;

            const response = await authFetch(`${config.apiBaseUrl}/login/notifications/history?user_id=${userId}`);
            if (!response || !response.ok) return;

            const notifications = await response.json();
            renderNotifications(notifications);
        } catch (error) {
            showNotificationMessage('Failed to load notifications');
        }
    }

    function renderNotifications(notifications) {
        if (!notificationDropdown) return;

        if (!notifications?.length) {
            notificationDropdown.innerHTML = '<li><a class="dropdown-item text-center py-3">No notifications</a></li>';
            updateBadge(0);
            return;
        }

        let unreadCount = 0;
        let html = notifications.map(notification => {
            const isUnread = !notification.is_read;
            if (isUnread) unreadCount++;

            return `
                <li>
                    <a class="dropdown-item px-3 py-2 border-bottom ${isUnread ? 'bg-light' : ''}" 
                       href="#" 
                       data-id="${notification.notification_id}"
                       onclick="markNotificationAsRead(${notification.notification_id}, this)">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <h6 class="mb-1">${escapeHtml(notification.title)}</h6>
                                <p class="mb-0 text-muted" style="font-size: 0.85rem;">${escapeHtml(notification.message)}</p>
                                <div class="d-flex justify-content-between mt-1">
                                    <small class="text-muted" style="font-size: 0.75rem;">${formatTimeAgo(notification.created_at)}</small>
                                    ${notification.notification_type ?
                    `<span class="badge bg-secondary" style="font-size: 0.65rem;">${notification.notification_type}</span>` : ''}
                                </div>
                            </div>
                        </div>
                    </a>
                </li>
            `;
        }).join('');

        notificationDropdown.innerHTML = html;
        updateBadge(unreadCount);
    }

    window.markNotificationAsRead = async function (notificationId, element) {
        try {
            const response = await authFetch(
                `${config.apiBaseUrl}/login/notifications/mark-as-read/${notificationId}`,
                {
                    method: 'POST',
                    credentials: 'include'
                }
            );

            if (!response || !response.ok) return;

            if (element) {
                element.classList.remove('bg-light');
                const unreadElements = notificationDropdown.querySelectorAll('.bg-light');
                updateBadge(unreadElements.length);
            }
        } catch (error) {
            showNotificationMessage('Failed to update notification status');
        }
    };

    function updateBadge(count) {
        if (!notificationBadge) return;

        if (count > 0) {
            notificationBadge.textContent = count > 9 ? '9+' : count;
            notificationBadge.style.display = 'inline-block';
        } else {
            notificationBadge.style.display = 'none';
        }
    }

    function showNotificationMessage(message) {
        if (notificationDropdown) {
            notificationDropdown.innerHTML = `
                <li>
                    <a class="dropdown-item text-center py-3 text-danger small">
                        <i class="bx bx-error-circle me-2"></i>
                        ${escapeHtml(message)}
                    </a>
                </li>
            `;
        }
    }

    function formatTimeAgo(dateString) {
        const now = new Date();
        const date = new Date(dateString);
        const jakartaTime = new Date(date.toLocaleString("en-US", { timeZone: "Asia/Jakarta" }));
        const diffInSeconds = Math.floor((now - jakartaTime) / 1000);
        if (isNaN(diffInSeconds)) return '';
        const intervals = [
            { label: 'year', seconds: 31536000 },
            { label: 'month', seconds: 2592000 },
            { label: 'day', seconds: 86400 },
            { label: 'hour', seconds: 3600 },
            { label: 'minute', seconds: 60 },
            { label: 'second', seconds: 1 }
        ];
        for (const interval of intervals) {
            const count = Math.floor(diffInSeconds / interval.seconds);
            if (count >= 1) {
                return `${count} ${interval.label}${count !== 1 ? 's' : ''} ago`;
            }
        }
        return 'just now';
    }

    function escapeHtml(unsafe) {
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    function redirectToLogin() {
        window.location.href = '/html/login.html';
    }

    // Inisialisasi
    function initialize() {
        loadNotifications();
        setInterval(loadNotifications, config.pollingInterval); 

        if (typeof Notification !== 'undefined' && Notification.permission !== 'denied') {
            Notification.requestPermission();
        }
    }

    initialize();
});
