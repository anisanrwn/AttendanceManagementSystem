// Global variables
let map;
let marker;
let circle;
let watchId;
let locationHistory = [];

// Office coordinates (replace with your actual office coordinates)
const OFFICE_LOCATION = {
    lat: -7.2575, // Example coordinates - replace with your office latitude
    lng: 112.7521 // Example coordinates - replace with your office longitude
};
const GEOFENCE_RADIUS = 100; // in meters - the allowed distance from office

// Initialize the map with the office location
function initMap() {
    // Create map centered on office location
    map = new google.maps.Map(document.getElementById('map'), {
        center: OFFICE_LOCATION,
        zoom: 17,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        streetViewControl: false
    });
    
    // Add office marker
    const officeMarker = new google.maps.Marker({
        position: OFFICE_LOCATION,
        map: map,
        title: 'Office Location',
        icon: {
            url: '../assets/img/icons/pin.png', // Add your office pin icon
            scaledSize: new google.maps.Size(40, 40)
        }
    });
    
    // Add office radius
    const officeRadius = new google.maps.Circle({
        strokeColor: '#696cff',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#696cff',
        fillOpacity: 0.2,
        map: map,
        center: OFFICE_LOCATION,
        radius: GEOFENCE_RADIUS
    });
}

// Request and track location
function requestLocationPermission() {
    if (!navigator.geolocation) {
        updateLocationStatus("Geolocation is not supported by your browser", "error");
        return;
    }
    
    // Show loading state
    updateLocationStatus("Requesting location access...", "pending");
    
    const options = {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 0
    };
    
    watchId = navigator.geolocation.watchPosition(
        handleLocationSuccess,
        handleLocationError,
        options
    );
    
    // Navigate to step 2
    goToStep(2);
}

// Handle successful location acquisition
function handleLocationSuccess(position) {
    const { latitude, longitude, accuracy } = position.coords;
    const timestamp = new Date(position.timestamp);
    
    // Update UI elements
    document.getElementById('currentLat').textContent = latitude.toFixed(6);
    document.getElementById('currentLng').textContent = longitude.toFixed(6);
    document.getElementById('locationAccuracy').textContent = accuracy.toFixed(1);
    document.getElementById('lastUpdated').textContent = timestamp.toLocaleTimeString();
    
    // Calculate distance from office
    const distance = calculateDistance(
        latitude, 
        longitude, 
        OFFICE_LOCATION.lat, 
        OFFICE_LOCATION.lng
    );
    document.getElementById('distanceToOffice').textContent = distance.toFixed(1);
    
    // Check if in geofence
    const isInGeofence = distance <= GEOFENCE_RADIUS;
    
    // Update UI based on location status
    if (isInGeofence) {
        updateLocationStatus("✅ You are within the office area", "success");
        document.getElementById('reasonForm').style.display = 'none';
        document.getElementById('verifyLocationBtn').disabled = false;
    } else {
        updateLocationStatus("❌ You are outside the office area", "error");
        document.getElementById('reasonForm').style.display = 'block';
        
        // Enable the next button only if they've entered a reason
        const reasonText = document.getElementById('reasonText');
        if (reasonText.value.trim().length > 10) {
            document.getElementById('verifyLocationBtn').disabled = false;
        } else {
            document.getElementById('verifyLocationBtn').disabled = true;
            
            // Add event listener to the reason textarea if not already added
            if (!reasonText.hasAttribute('data-listener-added')) {
                reasonText.addEventListener('input', function() {
                    document.getElementById('verifyLocationBtn').disabled = this.value.trim().length <= 10;
                });
                reasonText.setAttribute('data-listener-added', 'true');
            }
        }
    }
    
    // Add to location history
    addLocationToHistory({
        lat: latitude,
        lng: longitude,
        accuracy: accuracy,
        timestamp: timestamp,
        distance: distance,
        inGeofence: isInGeofence
    });
    
    // Update map
    updateMap(latitude, longitude, accuracy);
}

// Handle location error
function handleLocationError(error) {
    let message;
    switch (error.code) {
        case error.PERMISSION_DENIED:
            message = "Location permission denied";
            break;
        case error.POSITION_UNAVAILABLE:
            message = "Location information is unavailable";
            break;
        case error.TIMEOUT:
            message = "Location request timed out";
            break;
        default:
            message = "An unknown error occurred";
            break;
    }
    updateLocationStatus(message, "error");
    
    // Disable the next button
    document.getElementById('verifyLocationBtn').disabled = true;
}

// Update the map with the current position
function updateMap(lat, lng, accuracy) {
    const position = new google.maps.LatLng(lat, lng);
    
    // Center map on position
    map.setCenter(position);
    
    // Update or create marker
    if (!marker) {
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: 'Your Location'
        });
    } else {
        marker.setPosition(position);
    }
    
    // Update or create accuracy circle
    if (!circle) {
        circle = new google.maps.Circle({
            strokeColor: '#4285F4',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#4285F4',
            fillOpacity: 0.35,
            map: map,
            center: position,
            radius: accuracy
        });
    } else {
        circle.setCenter(position);
        circle.setRadius(accuracy);
    }
}

// Calculate distance between two points using Haversine formula
function calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371e3; // Earth's radius in meters
    const φ1 = lat1 * Math.PI / 180;
    const φ2 = lat2 * Math.PI / 180;
    const Δφ = (lat2 - lat1) * Math.PI / 180;
    const Δλ = (lon2 - lon1) * Math.PI / 180;

    const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ/2) * Math.sin(Δλ/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

    return R * c; // Distance in meters
}

// Update location status UI
function updateLocationStatus(message, status) {
    const statusElement = document.getElementById('locationStatus');
    statusElement.textContent = message;
    
    // Remove all status classes
    statusElement.classList.remove('status-success', 'status-error', 'status-pending');
    
    // Add appropriate class
    switch (status) {
        case 'success':
            statusElement.classList.add('status-success');
            break;
        case 'error':
            statusElement.classList.add('status-error');
            break;
        case 'pending':
            statusElement.classList.add('status-pending');
            break;
    }
}

// Add entry to location history
function addLocationToHistory(locationData) {
    // Add to array (limiting to most recent 5 entries)
    locationHistory.unshift(locationData);
    if (locationHistory.length > 5) {
        locationHistory.pop();
    }
    
    // Update UI
    const historyContainer = document.getElementById('locationHistory');
    historyContainer.innerHTML = ''; // Clear existing history
    
    locationHistory.forEach(location => {
        const entry = document.createElement('div');
        entry.classList.add('history-entry');
        
        const statusClass = location.inGeofence ? 'history-in-geofence' : 'history-outside-geofence';
        
        entry.innerHTML = `
            <div class="history-time">${location.timestamp.toLocaleTimeString()}</div>
            <div class="history-details">
                <span class="history-coords">${location.lat.toFixed(6)}, ${location.lng.toFixed(6)}</span>
                <span class="history-accuracy">Accuracy: ${location.accuracy.toFixed(1)}m</span>
                <span class="history-distance ${statusClass}">
                    ${location.distance.toFixed(1)}m from office
                    ${location.inGeofence ? '✅' : '❌'}
                </span>
            </div>
        `;
        
        historyContainer.appendChild(entry);
    });
}

// Navigation between steps
function goToStep(stepNumber) {
    // Hide all steps
    document.querySelectorAll('.step-container').forEach(container => {
        container.classList.remove('active-step');
    });
    
    // Show requested step
    document.getElementById(`step${stepNumber}Container`).classList.add('active-step');
    
    // Update progress tracker
    document.querySelectorAll('.progress-step').forEach((step, index) => {
        if (index + 1 <= stepNumber) {
            step.classList.add('active');
        } else {
            step.classList.remove('active');
        }
    });
    
    // Initialize map when going to step 2
    if (stepNumber === 2 && !map) {
        // Load Google Maps API
        if (!window.google || !window.google.maps) {
            const script = document.createElement('script');
            script.src = `https://maps.googleapis.com/maps/api/js?key=laalallala&libraries=geometry&callback=renderMap`;
            script.async = true;
            script.defer = true;
            document.head.appendChild(script);
        } else {
            initMap();
        }
    }
    
    // Start face recognition when going to step 3
    if (stepNumber === 3) {
        initFaceRecognition();
    }
}

// Go back to previous step
function goBack() {
    const currentStep = document.querySelector('.step-container.active-step');
    const currentStepNumber = parseInt(currentStep.id.replace('step', '').replace('Container', ''));
    
    if (currentStepNumber > 1) {
        goToStep(currentStepNumber - 1);
    }
}

// Go back to attendance page
function backToAttendance() {
    // Stop watching location
    if (watchId) {
        navigator.geolocation.clearWatch(watchId);
        watchId = null;
    }
    
    // Hide step page and show attendance page
    document.getElementById('step-page').style.display = 'none';
    document.getElementById('attendance-page').style.display = 'block';
}

// Set up event listeners for the page
document.addEventListener('DOMContentLoaded', function() {
    // Location permission button
    document.getElementById('allowLocationBtn').addEventListener('click', requestLocationPermission);
    
    // Back button
    document.getElementById('btn-back-step').addEventListener('click', goBack);
    
    // Back to attendance button
    document.getElementById('backToAttendanceBtn').addEventListener('click', backToAttendance);
    
    // Verify location button (proceed to face recognition)
    document.getElementById('verifyLocationBtn').addEventListener('click', function() {
        goToStep(3);
    });
    
    // Punch In button 
    document.getElementById('punchInBtn').addEventListener('click', function() {
        // Hide attendance page and show steps page
        document.getElementById('attendance-page').style.display = 'none';
        document.getElementById('step-page').style.display = 'block';
        goToStep(1);
    });
    
    // Add CSS for location status
    const style = document.createElement('style');
    style.textContent = `
        #map {
            height: 300px;
            width: 100%;
            margin-top: 15px;
            border-radius: 8px;
        }
        
        .status-indicator {
            padding: 8px;
            border-radius: 4px;
            text-align: center;
            font-weight: bold;
        }
        
        .status-success {
            background-color: #d7f5e9;
            color: #1ea97c;
        }
        
        .status-error {
            background-color: #ffe0e3;
            color: #ff3e54;
        }
        
        .status-pending {
            background-color: #fff2d6;
            color: #ffab00;
        }
        
        .location-history {
            max-height: 200px;
            overflow-y: auto;
        }
        
        .history-entry {
            padding: 8px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
        }
        
        .history-time {
            font-weight: bold;
            width: 90px;
        }
        
        .history-details {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .history-coords {
            font-family: monospace;
        }
        
        .history-accuracy {
            font-size: 0.85em;
            color: #666;
        }
        
        .history-in-geofence {
            color: #1ea97c;
        }
        
        .history-outside-geofence {
            color: #ff3e54;
        }
    `;
    document.head.appendChild(style);
});

// Initialize face recognition system
function initFaceRecognition() {
    const video = document.getElementById('videoFeed');
    const canvas = document.getElementById('canvasOverlay');
    const ctx = canvas.getContext('2d');
    
    // Check if camera is already running
    if (video.srcObject) {
        return;
    }
    
    // Request camera access
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
            video.srcObject = stream;
            
            // Start capturing frames for face recognition
            startFaceCapture(video, canvas, ctx);
        })
        .catch(err => {
            console.error('Error accessing the camera:', err);
            Swal.fire({
                icon: 'error',
                title: 'Camera Error',
                text: 'Unable to access the camera. Please check your permissions.',
                confirmButtonColor: '#696cff'
            });
        });
}

// Capture frames for face recognition
function startFaceCapture(video, canvas, ctx) {
    const captureInterval = setInterval(() => {
        if (video.readyState === 4) {
            // Draw video frame to canvas
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            
            // Draw face detection overlay
            drawFaceOverlay(ctx, canvas.width, canvas.height);
            
            // Capture frame and send to server for processing
            canvas.toBlob(blob => {
                sendFaceForVerification(blob);
            }, 'image/jpeg', 0.8);
        }
    }, 1000); // Capture every 1 second
    
    // Store interval ID to clear later
    video.dataset.captureInterval = captureInterval;
}

// Draw face detection overlay on canvas
function drawFaceOverlay(ctx, width, height) {
    // Draw a face guide overlay (example: oval guide)
    ctx.beginPath();
    ctx.ellipse(width/2, height/2, width/3, height/2.2, 0, 0, 2 * Math.PI);
    ctx.strokeStyle = 'rgba(105, 108, 255, 0.7)';
    ctx.lineWidth = 2;
    ctx.stroke();
    
    // Add scan effect
    const scanY = (Date.now() % 2000) / 2000 * height;
    ctx.beginPath();
    ctx.moveTo(0, scanY);
    ctx.lineTo(width, scanY);
    ctx.strokeStyle = 'rgba(105, 108, 255, 0.5)';
    ctx.lineWidth = 2;
    ctx.stroke();
}

// Send captured face to server for verification
function sendFaceForVerification(imageBlob) {
    // Create form data to send to server
    const formData = new FormData();
    formData.append('face_image', imageBlob);
    
    // Send to server
    fetch('/api/verify-face', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Face recognized successfully
            stopFaceCapture();
            
            // Complete attendance process
            completeAttendance(data);
        }
        // If not successful, continue capturing
    })
    .catch(error => {
        console.error('Error sending face for verification:', error);
    });
}

// Stop face capture process
function stopFaceCapture() {
    const video = document.getElementById('videoFeed');
    
    // Clear capture interval
    if (video.dataset.captureInterval) {
        clearInterval(parseInt(video.dataset.captureInterval));
    }
    
    // Stop video stream
    if (video.srcObject) {
        const tracks = video.srcObject.getTracks();
        tracks.forEach(track => track.stop());
        video.srcObject = null;
    }
}

// Complete attendance process
function completeAttendance(verificationData) {
    // Get reason text if outside geofence
    const reasonText = document.getElementById('reasonText').value.trim();
    
    // Create attendance data object
    const attendanceData = {
        userId: verificationData.userId,
        timestamp: new Date().toISOString(),
        location: {
            lat: parseFloat(document.getElementById('currentLat').textContent),
            lng: parseFloat(document.getElementById('currentLng').textContent),
            accuracy: parseFloat(document.getElementById('locationAccuracy').textContent)
        },
        distance: parseFloat(document.getElementById('distanceToOffice').textContent),
        inGeofence: verificationData.inGeofence,
        reason: reasonText || null
    };
    
    // Send attendance data to server
    fetch('/api/record-attendance', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(attendanceData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Show success message
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Your attendance has been recorded successfully.',
                confirmButtonColor: '#696cff'
            }).then(() => {
                // Update attendance UI
                updateAttendanceUI(data);
                
                // Go back to attendance page
                backToAttendance();
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: data.message || 'Failed to record attendance.',
                confirmButtonColor: '#696cff'
            });
        }
    })
    .catch(error => {
        console.error('Error recording attendance:', error);
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Failed to record attendance. Please try again.',
            confirmButtonColor: '#696cff'
        });
    });
}

// Update attendance UI after successful punch in/out
function updateAttendanceUI(data) {
    if (data.type === 'in') {
        // Update punch in time
        document.getElementById('inTime').textContent = data.formattedTime;
        document.getElementById('status').textContent = 'Checked In';
        document.getElementById('status').className = 'badge bg-label-success';
        
        // Enable punch out button
        document.getElementById('punchInBtn').disabled = true;
        document.getElementById('punchOutBtn').disabled = false;
    } else if (data.type === 'out') {
        // Update punch out time
        document.getElementById('outTime').textContent = data.formattedTime;
        document.getElementById('status').textContent = 'Checked Out';
        document.getElementById('status').className = 'badge bg-label-info';
        document.getElementById('totalHours').textContent = data.totalHours;
        
        // Disable both buttons
        document.getElementById('punchInBtn').disabled = true;
        document.getElementById('punchOutBtn').disabled = true;
    }
}