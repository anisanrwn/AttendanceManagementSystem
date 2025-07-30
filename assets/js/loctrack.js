import { showAlert } from './alert.js';
import { goToStep } from './attendance.js';
export { insideGeofence, currentPosition };

// Configuration
const OFFICE_LOCATION = { lat: -6.285542, lng: 107.170443 };
const GEOFENCE_RADIUS = 100; 
const LOCATION_UPDATE_INTERVAL = 10000; 
const LOCATION_TIMEOUT = 30000; 

// Global state
let map = null;
let userMarker = null;
let officeBoundary = null;
let insideGeofence = false;
let currentPosition = null;
let locationWatchId = null;
let userPath = null;
let userPathCoordinates = [];
let officeLocation = { lat: -6.285542, lng: 107.170443 };
let locationUpdateTimeoutId = null;

// Request access to device location
export function requestLocationAccess() {
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
    showAlert('error', message);
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
    locationUpdateTimeoutId = setTimeout(() => {
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

export function stopLocationTracking() {
    if (locationWatchId !== null) {
        navigator.geolocation.clearWatch(locationWatchId);
        locationWatchId = null;
    }
    
    if (locationUpdateTimeoutId !== null) {
        clearTimeout(locationUpdateTimeoutId);
        locationUpdateTimeoutId = null;
    }
}
