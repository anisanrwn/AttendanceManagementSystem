// Configuration - These should be loaded from your backend
const OFFICE_LOCATION = { lat: -6.473100484760882, lng: 106.85142504029916, }; 
const GEOFENCE_RADIUS = 500; // meters
const LOCATION_UPDATE_INTERVAL = 10000; // ms (10 seconds) - increased from 5s to reduce timeout issues
const LOCATION_TIMEOUT = 30000; // ms (30 seconds) - increased timeout for geolocation

// Global state
let map = null;
let userMarker = null;
let officeBoundary = null;
let insideGeofence = false;
let currentPosition = null;
let locationWatchId = null;
let userPath = null;
let userPathCoordinates = [];
let officeLocation = { lat: -6.473100484760882, lng: 106.85142504029916 }; // Default location

// Initialize the location tracking system
document.addEventListener('DOMContentLoaded', function() {
    setupEventListeners();
});

// Set up event listeners
function setupEventListeners() {
    
    // Punch In button
    document.getElementById('punchInBtn').addEventListener('click', () => {
        document.getElementById('attendance-page').style.display = 'none';
        document.getElementById('step-page').style.display = 'block';
        goToStep(1);
    });
    
    // Allow location access
    document.getElementById('allowLocationBtn').addEventListener('click', requestLocationAccess);
    
    // Back button (to previous step)
    document.getElementById('btn-back-step').addEventListener('click', () => {
        // Stop any ongoing location tracking when going back
        stopLocationTracking();
        goToStep(1);
    });
    
    // Verify location button
    document.getElementById('verifyLocationBtn').addEventListener('click', () => {
        if (insideGeofence || document.getElementById('reasonText').value.trim() !== '') {
            goToStep(3);
            setupFaceRecognition();
        } else {
            showAlert('warning', 'Please provide a reason why you are not in the designated area.');
        }
    });
}

function goToStep(stepNumber) {
  console.log("Going to step", stepNumber); // ✅ DEBUG

  document.querySelectorAll('.step-container').forEach(container => {
    container.classList.remove('active-step');
    container.style.display = 'none';
  });

  const currentStepContainer = document.getElementById(`step${stepNumber}Container`);
  if (!currentStepContainer) {
    alert(`step${stepNumber}Container NOT FOUND!`);
    return;
  }

  currentStepContainer.classList.add('active-step');
  currentStepContainer.style.display = 'block';
  console.log("Showing:", currentStepContainer.id); // ✅ DEBUG

  updateProgressTracker(stepNumber);
}


function updateProgressTracker(activeStep) {
    // Reset all steps
    document.querySelectorAll('.progress-step').forEach((step, index) => {
        step.classList.remove('active', 'completed');
        if (index + 1 < activeStep) {
            step.classList.add('completed');
        } else if (index + 1 === activeStep) {
            step.classList.add('active');
        }
    });
}

// Request access to device location
function requestLocationAccess() {
    // Reset and stop any previous location tracking
    stopLocationTracking();
    
    if (navigator.geolocation) {
        // Show loading state
        document.getElementById('allowLocationBtn').innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span> Getting Location...';
        document.getElementById('allowLocationBtn').disabled = true;
        
        // Start with a one-time position request with longer timeout
        navigator.geolocation.getCurrentPosition(
            positionSuccess,
            positionError,
            { 
                enableHighAccuracy: true,
                timeout: LOCATION_TIMEOUT, // Increased timeout for initial request
                maximumAge: 0
            }
        );
    } else {
        showAlert('danger', 'Geolocation is not supported by this browser.');
    }
}

// When position is successfully acquired
function positionSuccess(position) {
    currentPosition = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        accuracy: position.coords.accuracy,
    };
    
    // Update UI with current position
    updateLocationUI(currentPosition);
    
    // Add to path coordinates
    userPathCoordinates = []; // Clear previous path
    userPathCoordinates.push({ lat: currentPosition.lat, lng: currentPosition.lng });
    
    goToStep(2);
    initializeMap();
    
    // Start continuous location tracking
    startLocationTracking();
    
    // Reset button state
    document.getElementById('allowLocationBtn').innerHTML = 'Allow Location Access';
    document.getElementById('allowLocationBtn').disabled = false;
}

// When there's an error getting position
function positionError(error) {
    // Reset button state
    document.getElementById('allowLocationBtn').innerHTML = 'Allow Location Access';
    document.getElementById('allowLocationBtn').disabled = false;
    
    let message;
    switch(error.code) {
        case error.PERMISSION_DENIED:
            message = "You denied the request for geolocation.";
            break;
        case error.POSITION_UNAVAILABLE:
            message = "Location information is unavailable.";
            break;
        case error.TIMEOUT:
            message = "The request to get user location timed out. Please try again.";
            break;
        case error.UNKNOWN_ERROR:
            message = "An unknown error occurred.";
            break;
    }
    showAlert('danger', message);
}

// Start continuous location tracking
function startLocationTracking() {
    // Clear any existing watch
    if (locationWatchId !== null) {
        navigator.geolocation.clearWatch(locationWatchId);
    }
    
    // Set up continuous location tracking with higher timeout
    locationWatchId = navigator.geolocation.watchPosition(
        updateUserLocation,
        positionError,
        { 
            enableHighAccuracy: true,
            timeout: LOCATION_TIMEOUT, // Increased timeout
            maximumAge: 5000 // Allow positions up to 5 seconds old
        }
    );
    
    // Also set up a timer to request location updates at regular intervals
    scheduleLocationUpdate();
}

// Schedule next location update
function scheduleLocationUpdate() {
    // We'll use a separate timer for manual updates to ensure we get regular updates
    setTimeout(() => {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                updateUserLocation,
                (error) => console.log('Scheduled location update error:', error),
                { 
                    enableHighAccuracy: true,
                    timeout: LOCATION_TIMEOUT,
                    maximumAge: 5000
                }
            );
        }
        // Schedule the next update
        scheduleLocationUpdate();
    }, LOCATION_UPDATE_INTERVAL);
}

// Update the location UI with current position
function updateLocationUI(position) {
    // Update the location details in the UI
    document.getElementById('currentLat').textContent = position.lat.toFixed(6);
    document.getElementById('currentLng').textContent = position.lng.toFixed(6);
    document.getElementById('locationAccuracy').textContent = Math.round(position.accuracy);
    
    // Calculate distance from office if we have the map initialized
    if (map && google) {
        const userLatLng = new google.maps.LatLng(position.lat, position.lng);
        const officeLatLng = new google.maps.LatLng(officeLocation.lat, officeLocation.lng);
        const distance = google.maps.geometry.spherical.computeDistanceBetween(userLatLng, officeLatLng);
        document.getElementById('distanceToOffice').textContent = Math.round(distance);
    }
}

// Add a position to path coordinates for drawing on map
function addToPathCoordinates(position) {
    // Only add to path coordinates if significantly different from last point
    if (userPathCoordinates.length === 0 || 
        calculateDistance(
            userPathCoordinates[userPathCoordinates.length - 1],
            { lat: position.lat, lng: position.lng }
        ) > 5) { // Only add points if they're more than 5 meters apart (increased threshold)
        userPathCoordinates.push({ lat: position.lat, lng: position.lng });
        updateUserPath();
    }
}

// Calculate distance between two points
function calculateDistance(point1, point2) {
    // Haversine distance calculation
    const R = 6371e3; // Earth radius in meters
    const φ1 = point1.lat * Math.PI / 180;
    const φ2 = point2.lat * Math.PI / 180;
    const Δφ = (point2.lat - point1.lat) * Math.PI / 180;
    const Δλ = (point2.lng - point1.lng) * Math.PI / 180;
    
    const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ/2) * Math.sin(Δλ/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    
    return R * c;
}

async function initializeMap() {
    const api_key = await fetchMapsApiKey();
    // Register global callback
    window.renderMap = renderMap;

    const script = document.createElement('script');
    script.src = `https://maps.googleapis.com/maps/api/js?key=${api_key}&libraries=geometry&callback=renderMap`;
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);
}

async function fetchMapsApiKey() {
    try {
        const response = await fetch('http://localhost:8000/api/maps-key');
        const data = await response.json();
        return data.api_key;
    } catch (error) {
        showAlert('warning', 'Could not fetch Maps API key. Using fallback.');
        return null;
    }
}

// Render the map with current position
function renderMap() {
    const mapElement = document.getElementById('map');
    
    // Set map height
    mapElement.style.height = '400px';
    mapElement.style.width = '100%';
    mapElement.style.borderRadius = '10px';
    mapElement.style.marginBottom = '20px';
    mapElement.style.boxShadow = '0 4px 8px rgba(0,0,0,0.1)';
    
    map = new google.maps.Map(mapElement, {
        center: currentPosition,
        zoom: 16,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: false,
        streetViewControl: false
    });
    
    // Add user marker with accuracy circle
    userMarker = new google.maps.Marker({
        position: {lat: currentPosition.lat, lng: currentPosition.lng},
        map: map,
        title: "Your Location",
        animation: google.maps.Animation.DROP,
        icon: {
            url: 'https://maps.google.com/mapfiles/ms/icons/blue-dot.png',
        }
    });
    
    // Add accuracy circle around user
    const accuracyCircle = new google.maps.Circle({
        strokeColor: '#1e90ff',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#1e90ff',
        fillOpacity: 0.1,
        map: map,
        center: {lat: currentPosition.lat, lng: currentPosition.lng},
        radius: currentPosition.accuracy
    });
    userMarker.set('accuracyCircle', accuracyCircle);
    
    // Add office marker
    const officeMarker = new google.maps.Marker({
        position: officeLocation,
        map: map,
        title: "Office Location",
        icon: {
            url: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png',
        }
    });
    
    // Add geofence circle
    officeBoundary = new google.maps.Circle({
        strokeColor: '#1cc88a',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#1cc88a',
        fillOpacity: 0.1,
        map: map,
        center: officeLocation,
        radius: GEOFENCE_RADIUS
    });
    
    // Initialize user path
    userPath = new google.maps.Polyline({
        path: userPathCoordinates,
        geodesic: true,
        strokeColor: '#4e73df',
        strokeOpacity: 1.0,
        strokeWeight: 3
    });
    userPath.setMap(map);
    
    // Check if user is inside geofence
    checkGeofence();
}

// Update user location on the map
function updateUserLocation(position) {
    currentPosition = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        accuracy: position.coords.accuracy,
    };
    
    // Add to path coordinates
    addToPathCoordinates(currentPosition);
    
    // Update UI
    updateLocationUI(currentPosition);
    
    if (userMarker && map) {
        // Update user marker position
        userMarker.setPosition({lat: currentPosition.lat, lng: currentPosition.lng});
        
        // Update accuracy circle
        const accuracyCircle = userMarker.get('accuracyCircle');
        if (accuracyCircle) {
            accuracyCircle.setCenter({lat: currentPosition.lat, lng: currentPosition.lng});
            accuracyCircle.setRadius(currentPosition.accuracy);
        } else {
            // Create the accuracy circle if it doesn't exist
            const newAccuracyCircle = new google.maps.Circle({
                strokeColor: '#1e90ff',
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: '#1e90ff',
                fillOpacity: 0.1,
                map: map,
                center: {lat: currentPosition.lat, lng: currentPosition.lng},
                radius: currentPosition.accuracy
            });
            userMarker.set('accuracyCircle', newAccuracyCircle);
        }
        
        // Pan map to current position
        map.panTo({lat: currentPosition.lat, lng: currentPosition.lng});
    }
    
    checkGeofence();
}

// Update the user path on the map
function updateUserPath() {
    if (userPath && map) {
        userPath.setPath(userPathCoordinates);
    }
}

// Check if user is inside the geofence
function checkGeofence() {
    // Calculate distance between user and office
    if (!currentPosition || !map) return;
    
    const userLatLng = new google.maps.LatLng(currentPosition.lat, currentPosition.lng);
    const officeLatLng = new google.maps.LatLng(officeLocation.lat, officeLocation.lng);
    
    // Calculate distance in meters
    const distance = google.maps.geometry.spherical.computeDistanceBetween(userLatLng, officeLatLng);
    
    // Check if inside geofence
    insideGeofence = distance <= GEOFENCE_RADIUS;
    
    // Update UI
    const statusElement = document.getElementById('locationStatus');
    statusElement.textContent = insideGeofence ? 
        'You are inside the designated area' : 
        'You are outside the designated area';
    
    // Add status indicator classes for styling
    if (insideGeofence) {
        statusElement.classList.remove('outside-geofence');
        statusElement.classList.add('inside-geofence');
        document.getElementById('reasonForm').style.display = 'none';
    } else {
        statusElement.classList.remove('inside-geofence');
        statusElement.classList.add('outside-geofence');
        document.getElementById('reasonForm').style.display = 'block';
    }
    
    // Enable the next button
    document.getElementById('verifyLocationBtn').disabled = false;
}

// Stop location tracking
function stopLocationTracking() {
    // Clear location watch
    if (locationWatchId !== null) {
        navigator.geolocation.clearWatch(locationWatchId);
        locationWatchId = null;
    }
    
    // Clear any pending timeouts
    clearTimeout(window.locationUpdateTimeoutId);
}

// Show alert messages
function showAlert(type, message) {
    // Create alert element
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
    alertDiv.role = 'alert';
    
    // Add message
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    // Insert at top of container
    const container = document.querySelector('.card-body');
    container.insertBefore(alertDiv, container.firstChild);
    
    // Auto dismiss after 5 seconds
    setTimeout(() => {
        try {
            const bsAlert = new bootstrap.Alert(alertDiv);
            bsAlert.close();
        } catch (e) {
            // Fallback if bootstrap alert is not available
            alertDiv.remove();
        }
    }, 5000);
}

function setupFaceRecognition() {
  const video = document.getElementById('faceVideo');
  const startCameraBtn = document.getElementById('startCameraBtn');
  const captureFaceBtn = document.getElementById('captureFaceBtn');
  const faceStatus = document.getElementById('faceStatus');
  let stream = null;

  startCameraBtn.onclick = async () => {
    try {
      stream = await navigator.mediaDevices.getUserMedia({ video: true });
      video.srcObject = stream;
      captureFaceBtn.disabled = false;
      faceStatus.textContent = "Camera started. Please position your face.";
    } catch (err) {
      faceStatus.textContent = "Could not access camera: " + err.message;
    }
  };

  captureFaceBtn.onclick = async () => {
    if (!stream) {
      faceStatus.textContent = "Camera not started yet.";
      return;
    }
    // Capture frame dari video
    const canvas = document.createElement('canvas');
    canvas.width = video.videoWidth || 320;
    canvas.height = video.videoHeight || 240;
    const ctx = canvas.getContext('2d');
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
    const imageBase64 = canvas.toDataURL('image/jpeg').split(',')[1]; // tanpa prefix

    // Kirim data ke backend
    faceStatus.textContent = "Verifying face...";
    
    // Ambil lokasi terakhir dari global currentPosition
    const lat = currentPosition?.lat || 0;
    const lng = currentPosition?.lng || 0;

    // Ambil employee_id dari sessionStorage (pastikan kamu set ini saat login)
    const employeeId = sessionStorage.getItem('employee_id');
    if (!employeeId) {
      faceStatus.textContent = "Session expired, please login again.";
      return;
    }

    try {
      const response = await fetch('http://localhost:8000/attendance/clockin', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          employee_id: parseInt(employeeId),
          image_base64: imageBase64,
          clock_in_latitude: lat,
          clock_in_longitude: lng,
          clock_in_reason: ''
        }),
      });
      const data = await response.json();

      if (response.ok && data.face_verified) {
        faceStatus.textContent = "Face verified! Attendance recorded.";
        // Optional: stop camera stream after success
        stream.getTracks().forEach(track => track.stop());
        captureFaceBtn.disabled = true;
        startCameraBtn.disabled = true;
      } else {
        faceStatus.textContent = "Face not recognized. Please try again.";
      }
    } catch (error) {
      faceStatus.textContent = "Error verifying face: " + error.message;
    }
  };
}
