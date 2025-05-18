document.addEventListener('DOMContentLoaded', function() {
    // Konfigurasi dasar
    const config = {
        apiBaseUrl: 'http://127.0.0.1:8000',
        maxNotifications: 20,
        reconnectDelay: 5000,
        notificationSound: '/sounds/notification.mp3' // Optional
    };

    // State management
    let eventSource = null;
    let isConnected = false;
    let notificationCleanup = null;

    // Elemen UI
    const notificationDropdown = document.querySelector('.dropdown-menu[aria-labelledby="notification-area"]');
    const notificationBadge = document.getElementById('notification-badge');

    // 1. Fungsi Utama Autentikasi
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
            console.error('Token refresh failed:', error);
            redirectToLogin();
            return null;
        }
    }

    async function authFetch(url, options = {}) {
        try {
            // Setup headers
            const token = localStorage.getItem('token');
            const headers = {
                'Content-Type': 'application/json',
                ...options.headers
            };

            if (token) {
                headers['Authorization'] = `Bearer ${token}`;
            }

            // First attempt
            let response = await fetch(url, { ...options, headers });
            
            // Token expired handling
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

    // 2. Fungsi Notifikasi
    async function loadNotifications() {
        try {
            // Tampilkan loading state
            notificationDropdown.innerHTML = '<li><a class="dropdown-item text-center py-3">Loading notifications...</a></li>';

            const userId = await getUserId();
            if (!userId) return;

            const response = await authFetch(
                `${config.apiBaseUrl}/login/notifications/history?user_id=${userId}`
            );

            if (!response) return;

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const notifications = await response.json();
            renderNotifications(notifications);
        } catch (error) {
            console.error('Failed to load notifications:', error);
            showNotificationMessage('Failed to load notifications. Please try again.');
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

        html += `
            <li><hr class="dropdown-divider my-1"></li>
            
        `;
        
        notificationDropdown.innerHTML = html;
        updateBadge(unreadCount);
    }

    window.markNotificationAsRead = async function(notificationId, element) {
        try {
            const response = await authFetch(
                `${config.apiBaseUrl}/login/notifications/mark-as-read/${notificationId}`, {
                    method: 'POST',
                    credentials: 'include'
                }
            );

            if (!response) return;

            if (!response.ok) {
                throw new Error('Failed to mark as read');
            }

            // Update UI
            if (element) {
                element.classList.remove('bg-light');
                const unreadElements = notificationDropdown.querySelectorAll('.bg-light');
                updateBadge(unreadElements.length);
            }
            
        } catch (error) {
            console.error('Error marking notification:', error);
            showNotificationMessage('Failed to update notification status');
        }
    };

    // 3. Real-time SSE Connection
    async function setupSSE() {
        try {
            if (isConnected) return;

            const userId = await getUserId();
            if (!userId) return;

            const token = localStorage.getItem('token');
            if (!token) {
                redirectToLogin();
                return;
            }

            eventSource = new EventSource(
                `${config.apiBaseUrl}/login/notifications/stream?user_id=${userId}&token=${token}`
            );

            eventSource.onopen = () => {
                console.log('SSE connection established');
                isConnected = true;
            };

            eventSource.onmessage = (event) => {
                if (event.data === ': heartbeat') return;

                try {
                    const { type, notification } = JSON.parse(event.data);
                    if (type === 'new_notification') {
                        handleNewNotification(notification);
                    }
                } catch (error) {
                    console.error('Error parsing SSE data:', error);
                }
            };

            eventSource.onerror = () => {
                console.error('SSE connection error');
                reconnectSSE();
            };

        } catch (error) {
            console.error('SSE setup failed:', error);
            reconnectSSE();
        }
    }

    function handleNewNotification(notification) {
        // Update UI
        addNotificationToUI(notification);
        
        // Update badge
        const currentCount = parseInt(notificationBadge.textContent) || 0;
        updateBadge(currentCount + 1);

        // Play sound if enabled
        if (typeof Notification !== 'undefined' && Notification.permission === 'granted') {
            new Notification(notification.title, { 
                body: notification.message,
                icon: '/img/notification-icon.png'
            });
            
            playNotificationSound();
        }
    }

    function addNotificationToUI(notification) {
        if (!notificationDropdown) return;

        // Remove "no notifications" message if exists
        if (notificationDropdown.innerHTML.includes('No notifications') || 
            notificationDropdown.innerHTML.includes('Loading notifications')) {
            notificationDropdown.innerHTML = '';
        }

        const notificationElement = `
            <li>
                <a class="dropdown-item px-3 py-2 border-bottom bg-light" 
                   href="#"
                   data-id="${notification.notification_id}"
                   onclick="markNotificationAsRead(${notification.notification_id}, this)">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <h6 class="mb-1">${escapeHtml(notification.title)}</h6>
                            <p class="mb-0 text-muted" style="font-size: 0.85rem;">${escapeHtml(notification.message)}</p>
                            <div class="d-flex justify-content-between mt-1">
                                <small class="text-muted" style="font-size: 0.75rem;">${formatTimeAgo(notification.created_at)}</small>
                                <span class="badge bg-primary" style="font-size: 0.65rem;">New</span>
                            </div>
                        </div>
                    </div>
                </a>
            </li>
        `;

        const viewAllLink = notificationDropdown.querySelector('a[href="/notifications"]');
        if (viewAllLink?.parentElement) {
            viewAllLink.parentElement.insertAdjacentHTML('beforebegin', notificationElement);
        } else {
            notificationDropdown.insertAdjacentHTML('afterbegin', notificationElement);
        }
    }

    function reconnectSSE() {
        if (eventSource) {
            eventSource.close();
            isConnected = false;
        }
        setTimeout(setupSSE, config.reconnectDelay);
    }

    // 4. UI Helpers
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

    function playNotificationSound() {
        try {
            if (config.notificationSound) {
                const audio = new Audio(config.notificationSound);
                audio.play().catch(e => console.error('Sound play failed:', e));
            }
        } catch (error) {
            console.error('Notification sound error:', error);
        }
    }

    // 5. Utility Functions
function formatTimeAgo(dateString) {
    const date = new Date(dateString);
    const now = new Date();

    // Hitung selisih dalam detik
    const seconds = Math.floor((now - date) / 1000);

    // Jika kurang dari 1 menit
    if (seconds < 60) return 'Just now';

    // Jika kurang dari 1 jam
    if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;

    // Jika kurang dari 1 hari
    if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;

    // Jika lebih dari 1 hari, tampilkan waktu dengan jam WIB
    // WIB = UTC+7, jadi kita tambahkan 7 jam ke waktu UTC
    const utc = date.getTime() + (date.getTimezoneOffset() * 60000);
    const wibTime = new Date(utc + (7 * 3600000));

    // Format jam dan menit dengan leading zero
    const hours = wibTime.getHours().toString().padStart(2, '0');
    const minutes = wibTime.getMinutes().toString().padStart(2, '0');

    return `${hours}:${minutes} WIB`;
}


    function escapeHtml(unsafe) {
        return unsafe
            .toString()
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

  

    // 6. Initialization and Cleanup
    function initialize() {
        // Load initial notifications
        loadNotifications();
        
        // Setup real-time connection
        setupSSE();
        
        // Request notification permission
        if (typeof Notification !== 'undefined' && Notification.permission !== 'denied') {
            Notification.requestPermission();
        }

        // Return cleanup function
        return () => {
            if (eventSource) {
                eventSource.close();
                isConnected = false;
            }
        };
    }

    // Start the system
    notificationCleanup = initialize();

    // Setup cleanup handlers
    window.addEventListener('beforeunload', notificationCleanup);
    window.addEventListener('pagehide', notificationCleanup);
});