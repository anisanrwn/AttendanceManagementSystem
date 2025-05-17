// Configuration - These should be loaded from your backend
const OFFICE_LOCATION = { lat: -6.473100484760882, lng: 106.85142504029916, }; 
const GEOFENCE_RADIUS = 500; // meters
const LOCATION_UPDATE_INTERVAL = 5000; // ms (5 seconds)
const LOCATION_HISTORY_MAX = 20; // Maximum number of location entries to show

// Global state
let map = null;
let userMarker = null;
let officeBoundary = null;
let insideGeofence = false;
let currentPosition = null;
let locationWatchId = null;
let locationHistoryArray = [];
let locationUpdateTimeoutId = null;
let userPath = null;
let userPathCoordinates = [];
let officeLocation = { lat: -6.473100484760882, lng: 106.85142504029916 }; // Default location

// Initialize the location tracking system
document.addEventListener('DOMContentLoaded', function() {
    setupEventListeners();
});

// Set up event listeners
function setupEventListeners() {
    // Back to attendance button
    document.getElementById('backToAttendanceBtn').addEventListener('click', () => {
        document.getElementById('step-page').style.display = 'none';
        document.getElementById('attendance-page').style.display = 'block';
    });
    
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
        goToStep(1);
    });
    
    // Verify location button
    document.getElementById('verifyLocationBtn').addEventListener('click', () => {
        if (insideGeofence || document.getElementById('reasonText').value.trim() !== '') {
            goToStep(3);
            // Here you would initialize face recognition
            // initializeFaceRecognition();
        } else {
            showAlert('warning', 'Please provide a reason why you are not in the designated area.');
        }
    });
}

function goToStep(stepNumber) {
    // Hide all steps
    document.querySelectorAll('.step-container').forEach(container => {
        container.classList.remove('active-step');
        container.style.display = 'none';
    });
    
    // Show the current step
    const currentStepContainer = document.getElementById(`step${stepNumber}Container`);
    currentStepContainer.classList.add('active-step');
    currentStepContainer.style.display = 'block';
    
    // Update progress tracker
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
    if (navigator.geolocation) {
        // Show loading state
        document.getElementById('allowLocationBtn').innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span> Getting Location...';
        document.getElementById('allowLocationBtn').disabled = true;
        
        // Start with a one-time position request
        navigator.geolocation.getCurrentPosition(
            positionSuccess,
            positionError,
            { 
                enableHighAccuracy: true,
                timeout: 10000,
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
    
    // Add this position to history
    addToLocationHistory(currentPosition);
    
    // Update UI with current position
    updateLocationUI(currentPosition);
    
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
            message = "The request to get user location timed out.";
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
    
    // Set up continuous location tracking with high accuracy
    locationWatchId = navigator.geolocation.watchPosition(
        updateUserLocation,
        positionError,
        { 
            enableHighAccuracy: true,
            timeout: 10000,
            maximumAge: 0
        }
    );
    
    // Also set up a timer to request location updates at regular intervals
    scheduleLocationUpdate();
}

// Schedule next location update
function scheduleLocationUpdate() {
    // Clear any existing timeout
    if (locationUpdateTimeoutId !== null) {
        clearTimeout(locationUpdateTimeoutId);
    }
    
    // Schedule next update
    locationUpdateTimeoutId = setTimeout(() => {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                updateUserLocation,
                (error) => console.log('Scheduled location update error:', error),
                { 
                    enableHighAccuracy: true,
                    timeout: 10000,
                    maximumAge: 0
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

// Add a position to location history
function addToLocationHistory(position) {
    // Add new position to the history array
    locationHistoryArray.unshift({
        lat: position.lat,
        lng: position.lng,
        accuracy: position.accuracy,
    });
    
    // Limit array size
    if (locationHistoryArray.length > LOCATION_HISTORY_MAX) {
        locationHistoryArray = locationHistoryArray.slice(0, LOCATION_HISTORY_MAX);
    }
    
    // Also add to path coordinates for drawing on map
    if (userPathCoordinates.length === 0 || 
        calculateDistance(
            userPathCoordinates[userPathCoordinates.length - 1],
            { lat: position.lat, lng: position.lng }
        ) > 2) { // Only add points if they're more than 2 meters apart
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

    if (!api_key) {
        console.error("No API key available");
        return;
    }

    console.log("Injecting Google Maps script with API key:", api_key);

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
        console.log("MAPS KEY from backend fetch:", data); // 🟡 DEBUG LOG
        return data.api_key;
    } catch (error) {
        console.error('Error fetching Maps API key:', error);
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
    
    // Add to location history
    addToLocationHistory(currentPosition);
    
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
    
    // Clear location update timeout
    if (locationUpdateTimeoutId !== null) {
        clearTimeout(locationUpdateTimeoutId);
        locationUpdateTimeoutId = null;
    }
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