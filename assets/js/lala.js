// Constants for geofencing and location tracking
const OFFICE_LOCATION = { lat: -6.473100484760882, lng: 106.85142504029916 }; 
const GEOFENCE_RADIUS = 500; // meters
const LOCATION_UPDATE_INTERVAL = 5000; // ms (5 seconds)
const LOCATION_HISTORY_MAX = 20; 

// Global variables
let currentPosition = null;
let locationWatchId = null;
let locationUpdateTimeoutId = null;
let map, userMarker, accuracyCircle;
let locationHistoryArray = [];
let userPathCoordinates = [];
let userPath;
let officeBoundary;
let insideGeofence = false;
let currentStep = 1;
let mapInitialized = false;

// Initialize when the document is ready
document.addEventListener('DOMContentLoaded', () => {
    setupEventListeners();
});

function setupEventListeners() {
    document.getElementById('allowLocationBtn').addEventListener('click', requestLocationAccess);

    document.getElementById('verifyLocationBtn').addEventListener('click', () => {
        if (insideGeofence || document.getElementById('reasonText').value.trim() !== '') {
            goToStep(3);
        } else {
            showNotification('Error', 'Please provide a reason why you are not in the designated area.');
        }
    });
    
    // Add back button listener if it exists
    const backButton = document.getElementById('btn-back-step');
    if (backButton) {
        backButton.addEventListener('click', () => {
            goToStep(currentStep - 1);
        });
    }
    
    // Add back to attendance button if exists
    const backToAttendanceBtn = document.getElementById('backToAttendanceBtn');
    if (backToAttendanceBtn) {
        backToAttendanceBtn.addEventListener('click', () => {
            // Hide step page and show attendance page
            document.getElementById('step-page').style.display = 'none';
            document.getElementById('attendance-page').style.display = 'block';
        });
    }
}

function goToStep(stepNumber) {
    // Hide all steps
    document.querySelectorAll('.step-container').forEach(container => {
        container.classList.remove('active-step');
    });
    
    // Show the current step
    document.getElementById(`step${stepNumber}Container`).classList.add('active-step');
    
    // Update progress tracker
    updateProgressTracker(stepNumber);
    
    // Update current step
    currentStep = stepNumber;
    
    // If moving to step 2 and we have location, initialize map
    if (stepNumber === 2 && currentPosition) {
        // Load Google Maps if needed
        if (!mapInitialized) {
            loadGoogleMapsScript();
        } else if (map) {
            // Refresh the map if it exists
            google.maps.event.trigger(map, 'resize');
        }
    }
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

function requestLocationAccess() {
    if (navigator.geolocation) {
        // Show loading indicator
        const allowBtn = document.getElementById('allowLocationBtn');
        if (allowBtn) {
            allowBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Getting Location...';
            allowBtn.disabled = true;
        }
        
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
        showNotification('Error', 'Geolocation is not supported by this browser.');
    }
}

function positionSuccess(position) {
    // Reset button state if needed
    const allowBtn = document.getElementById('allowLocationBtn');
    if (allowBtn) {
        allowBtn.innerHTML = 'Allow Location Access';
        allowBtn.disabled = false;
    }
    
    currentPosition = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        accuracy: position.coords.accuracy,
        timestamp: position.timestamp
    };
    
    // Add this position to history
    addToLocationHistory(currentPosition);
    
    // Update UI with current position
    updateLocationUI(currentPosition);
    
    // Move to step 2
    goToStep(2);
    
    // Start continuous location tracking
    startLocationTracking();
}

function positionError(error) {
    // Reset button state
    const allowBtn = document.getElementById('allowLocationBtn');
    if (allowBtn) {
        allowBtn.innerHTML = 'Allow Location Access';
        allowBtn.disabled = false;
    }
    
    let message;
    switch(error.code) {
        case error.PERMISSION_DENIED:
            message = "You denied the request for geolocation. Please allow location access to continue.";
            break;
        case error.POSITION_UNAVAILABLE:
            message = "Location information is unavailable. Please check your device settings.";
            break;
        case error.TIMEOUT:
            message = "The request to get your location timed out. Please try again.";
            break;
        case error.UNKNOWN_ERROR:
            message = "An unknown error occurred while getting your location. Please try again.";
            break;
    }
    showNotification('Location Error', message);
}

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
    // This helps ensure we get updates even if the device doesn't move much
    scheduleLocationUpdate();
}

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

function updateLocationUI(position) {
    // Update the location details in the UI
    document.getElementById('currentLat').textContent = position.lat.toFixed(6);
    document.getElementById('currentLng').textContent = position.lng.toFixed(6);
    document.getElementById('locationAccuracy').textContent = Math.round(position.accuracy);
    document.getElementById('lastUpdated').textContent = new Date(position.timestamp).toLocaleTimeString();
    
    // Calculate distance from office if we have map geometry available
    updateDistanceCalculation();
}

function updateDistanceCalculation() {
    if (!currentPosition) return;
    
    try {
        // Check if we have the maps API available
        if (window.google && google.maps && google.maps.geometry) {
            const userLatLng = new google.maps.LatLng(currentPosition.lat, currentPosition.lng);
            const officeLatLng = new google.maps.LatLng(OFFICE_LOCATION.lat, OFFICE_LOCATION.lng);
            const distance = google.maps.geometry.spherical.computeDistanceBetween(userLatLng, officeLatLng);
            document.getElementById('distanceToOffice').textContent = Math.round(distance);
        } else {
            // Fallback to our own calculation if Google Maps isn't available
            const distance = calculateDistance(
                currentPosition,
                OFFICE_LOCATION
            );
            document.getElementById('distanceToOffice').textContent = Math.round(distance);
        }
    } catch (error) {
        console.error("Error calculating distance:", error);
        // Fallback if something goes wrong
        const distance = calculateDistance(
            currentPosition,
            OFFICE_LOCATION
        );
        document.getElementById('distanceToOffice').textContent = Math.round(distance);
    }
}

function addToLocationHistory(position) {
    // Add new position to the history array
    locationHistoryArray.unshift({
        lat: position.lat,
        lng: position.lng,
        accuracy: position.accuracy,
        timestamp: position.timestamp || Date.now()
    });
    
    // Limit array size
    if (locationHistoryArray.length > LOCATION_HISTORY_MAX) {
        locationHistoryArray = locationHistoryArray.slice(0, LOCATION_HISTORY_MAX);
    }
    
    // Update the UI if the history container exists
    const historyContainer = document.getElementById('locationHistory');
    if (historyContainer) {
        updateLocationHistoryUI();
    }
    
    // Add to path coordinates for drawing on map
    if (userPathCoordinates.length === 0 || 
        calculateDistance(
            userPathCoordinates[userPathCoordinates.length - 1],
            { lat: position.lat, lng: position.lng }
        ) > 2) { // Only add points if they're more than 2 meters apart
        userPathCoordinates.push({ lat: position.lat, lng: position.lng });
        updateUserPath();
    }
}

function calculateDistance(point1, point2) {
    // Simple Haversine distance calculation
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

function updateLocationHistoryUI() {
    const historyContainer = document.getElementById('locationHistory');
    if (!historyContainer) return;
    
    historyContainer.innerHTML = '';
    
    locationHistoryArray.forEach((location, index) => {
        const time = new Date(location.timestamp).toLocaleTimeString();
        let accuracyClass = 'accuracy-high';
        if (location.accuracy > 50) {
            accuracyClass = 'accuracy-low';
        } else if (location.accuracy > 20) {
            accuracyClass = 'accuracy-medium';
        }
        
        const historyItem = document.createElement('div');
        historyItem.className = 'location-history-item';
        historyItem.innerHTML = `
            <span class="accuracy-indicator ${accuracyClass}"></span>
            <strong>${time}</strong> - 
            Lat: ${location.lat.toFixed(6)}, 
            Lng: ${location.lng.toFixed(6)} 
            (±${Math.round(location.accuracy)}m)
        `;
        historyContainer.appendChild(historyItem);
    });
}

// Improved Google Maps loading function
function loadGoogleMapsScript() {
    // First check if Google Maps is already loaded
    if (typeof google !== 'undefined' && google.maps) {
        renderMap();
        return;
    }
    
    // Show loading indicator in map container
    const mapElement = document.getElementById('map');
    if (mapElement) {
        mapElement.innerHTML = '<div class="map-loading"><i class="fas fa-spinner fa-spin"></i> Loading map...</div>';
    }
    
    console.log("Attempting to fetch Google Maps API key...");
    
    // Create a function to handle maps load success
    window.initMap = function() {
        console.log("Google Maps initialized");
        mapInitialized = true;
        renderMap();
    };
    
    // Try to fetch the API key from the server
    fetch("http://localhost:8000/api/maps-key")
        .then(response => {
            if (!response.ok) {
                throw new Error(`API response not OK: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            if (!data.api_key) {
                throw new Error("API Key not found in response");
            }
            
            // Load the Google Maps script with the secure API key
            const script = document.createElement("script");
            
            // Add error handling
            script.onerror = handleMapLoadFailure;
            
            // Make sure we're using HTTPS
            script.src = `https://maps.googleapis.com/maps/api/js?key=${data.api_key}&libraries=geometry&callback=initMap`;
            script.async = true;
            script.defer = true;
            document.head.appendChild(script);
            
            // Set a timeout to catch if Google Maps takes too long to load
            setTimeout(() => {
                if (!mapInitialized) {
                    console.warn("Google Maps failed to initialize within timeout period");
                    handleMapLoadFailure();
                }
            }, 10000); // 10 second timeout
        })
        .catch(error => {
            console.error("Error loading Google Maps:", error);
            handleMapLoadFailure();
        });
}

function renderMap() {
    const mapElement = document.getElementById('map');
    if (!mapElement || !currentPosition) {
        console.error("Map element or current position not available");
        return;
    }
    
    try {
        // Create the map
        map = new google.maps.Map(mapElement, {
            center: currentPosition,
            zoom: 16,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            streetViewControl: false,
            fullscreenControl: false
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
        accuracyCircle = new google.maps.Circle({
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
            position: OFFICE_LOCATION,
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
            center: OFFICE_LOCATION,
            radius: GEOFENCE_RADIUS
        });
        
        // Initialize user path
        userPath = new google.maps.Polyline({
            path: userPathCoordinates,
            geodesic: true,
            strokeColor: '#4e73df',
            strokeOpacity: 1.0,
            strokeWeight: 3,
            map: map
        });
        
        // Add a "center map" button
        const centerControlDiv = document.createElement('div');
        const centerControl = createCenterControl(map);
        centerControlDiv.appendChild(centerControl);
        map.controls[google.maps.ControlPosition.TOP_RIGHT].push(centerControlDiv);
        
        // Check if user is inside geofence
        checkGeofence();
        
        // Handle Google Maps API errors
        window.gm_authFailure = function() {
            console.error("Google Maps authentication failed");
            handleApiKeyError();
        };
        
        console.log("Map rendering completed successfully");
    } catch (error) {
        console.error("Error rendering map:", error);
        handleApiKeyError();
    }
}

// Create a control to recenter the map
function createCenterControl(map) {
    const controlButton = document.createElement('button');
    controlButton.textContent = 'Center Map';
    controlButton.className = 'custom-map-control';
    controlButton.title = 'Click to recenter the map';
    controlButton.type = 'button';
    
    // Setup CSS for the control
    controlButton.style.backgroundColor = '#fff';
    controlButton.style.border = '2px solid #ccc';
    controlButton.style.borderRadius = '3px';
    controlButton.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlButton.style.color = 'rgb(25,25,25)';
    controlButton.style.cursor = 'pointer';
    controlButton.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlButton.style.fontSize = '16px';
    controlButton.style.lineHeight = '38px';
    controlButton.style.margin = '8px 0 22px';
    controlButton.style.padding = '0 5px';
    controlButton.style.textAlign = 'center';
    
    // Setup the click event listener
    controlButton.addEventListener('click', () => {
        if (currentPosition) {
            map.panTo(new google.maps.LatLng(currentPosition.lat, currentPosition.lng));
        }
    });
    
    return controlButton;
}

function updateUserLocation(position) {
    currentPosition = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        accuracy: position.coords.accuracy,
        timestamp: position.timestamp
    };
    
    // Add to location history
    addToLocationHistory(currentPosition);
    
    // Update UI
    updateLocationUI(currentPosition);
    
    if (mapInitialized && userMarker && map) {
        // Update user marker position
        userMarker.setPosition({lat: currentPosition.lat, lng: currentPosition.lng});
        
        // Update accuracy circle
        const accuracyCircle = userMarker.get('accuracyCircle');
        if (accuracyCircle) {
            accuracyCircle.setCenter({lat: currentPosition.lat, lng: currentPosition.lng});
            accuracyCircle.setRadius(currentPosition.accuracy);
        }
        
        // Pan map to current position - only if "follow" mode is enabled
        // (Could add a toggle for this feature)
        map.panTo({lat: currentPosition.lat, lng: currentPosition.lng});
        
        checkGeofence();
    } else {
        // Without map, check geofence using calculation
        checkGeofenceWithoutMap();
    }
}

function updateUserPath() {
    if (!mapInitialized || !map || !google || !google.maps) return;
    
    // Check if userPath exists, create it if it doesn't
    if (!userPath) {
        userPath = new google.maps.Polyline({
            path: userPathCoordinates,
            geodesic: true,
            strokeColor: '#4e73df',
            strokeOpacity: 1.0,
            strokeWeight: 3
        });
        userPath.setMap(map);
    } else {
        // Path exists, just update it
        userPath.setPath(userPathCoordinates);
    }
}

function checkGeofence() {
    try {
        // Check dependencies
        if (!currentPosition) {
            console.warn("checkGeofence: Current position not available");
            return;
        }
        
        if (!map || !google || !google.maps || !google.maps.geometry) {
            console.warn("checkGeofence: Google Maps or geometry library not available");
            checkGeofenceWithoutMap();
            return;
        }
        
        const userLatLng = new google.maps.LatLng(currentPosition.lat, currentPosition.lng);
        const officeLatLng = new google.maps.LatLng(OFFICE_LOCATION.lat, OFFICE_LOCATION.lng);
        
        // Calculate distance in meters
        const distance = google.maps.geometry.spherical.computeDistanceBetween(userLatLng, officeLatLng);
        
        // Check if inside geofence
        insideGeofence = distance <= GEOFENCE_RADIUS;
        
        updateGeofenceUI();
        
    } catch (error) {
        console.error("Error in checkGeofence:", error);
        checkGeofenceWithoutMap();
    }
}

function checkGeofenceWithoutMap() {
    if (!currentPosition) return;
    
    // Calculate distance using our own function
    const distance = calculateDistance(currentPosition, OFFICE_LOCATION);
    insideGeofence = distance <= GEOFENCE_RADIUS;
    
    updateGeofenceUI();
}

function updateGeofenceUI() {
    // Update UI
    const statusElement = document.getElementById('locationStatus');
    if (!statusElement) {
        console.warn("updateGeofenceUI: Status element not found");
        return;
    }
    
    statusElement.textContent = insideGeofence ? 
        'You are inside the designated area' : 
        'You are outside the designated area';
    
    if (insideGeofence) {
        statusElement.classList.remove('outside-geofence');
        statusElement.classList.add('inside-geofence');
        const reasonForm = document.getElementById('reasonForm');
        if (reasonForm) reasonForm.style.display = 'none';
    } else {
        statusElement.classList.remove('inside-geofence');
        statusElement.classList.add('outside-geofence');
        const reasonForm = document.getElementById('reasonForm');
        if (reasonForm) reasonForm.style.display = 'block';
    }
    
    // Enable the next button
    const verifyBtn = document.getElementById('verifyLocationBtn');
    if (verifyBtn) verifyBtn.disabled = false;
}

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

function handleApiKeyError() {
    console.error("Google Maps API key error detected");
    
    // Indicate map failure but continue tracking
    const mapElement = document.getElementById('map');
    if (mapElement) {
        mapElement.innerHTML = `
            <div class="map-error">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Map display is currently unavailable.</p>
                <p>Your location is still being tracked.</p>
            </div>
        `;
    }
    
    // We can still use our own calculation for geofencing
    checkGeofenceWithoutMap();
    
    // Show error to user
    showNotification('Map Error', 
        "There was a problem with the map service. Your location is still being tracked, but the map display may not work correctly."
    );
}

// Helper function to show notifications
function showNotification(title, message) {
    // You can implement this based on your UI library
    // For example using a toast, alert, or custom notification component
    console.log(`${title}: ${message}`);
    
    // Check if a notification container exists
    let notificationContainer = document.getElementById('notification-container');
    
    // Create it if it doesn't exist
    if (!notificationContainer) {
        notificationContainer = document.createElement('div');
        notificationContainer.id = 'notification-container';
        notificationContainer.style.position = 'fixed';
        notificationContainer.style.top = '20px';
        notificationContainer.style.right = '20px';
        notificationContainer.style.zIndex = '9999';
        document.body.appendChild(notificationContainer);
    }
    
    // Create the notification element
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.innerHTML = `
        <div class="notification-header">
            <strong>${title}</strong>
            <button class="close-notification">&times;</button>
        </div>
        <div class="notification-body">
            ${message}
        </div>
    `;
    
    // Style the notification
    notification.style.backgroundColor = '#fff';
    notification.style.border = '1px solid #ddd';
    notification.style.borderRadius = '5px';
    notification.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
    notification.style.margin = '10px 0';
    notification.style.maxWidth = '300px';
    notification.style.overflow = 'hidden';
    
    // Style header
    const header = notification.querySelector('.notification-header');
    header.style.backgroundColor = '#f8f9fa';
    header.style.padding = '10px 15px';
    header.style.borderBottom = '1px solid #ddd';
    header.style.display = 'flex';
    header.style.justifyContent = 'space-between';
    header.style.alignItems = 'center';
    
    // Style close button
    const closeBtn = notification.querySelector('.close-notification');
    closeBtn.style.border = 'none';
    closeBtn.style.background = 'transparent';
    closeBtn.style.fontSize = '20px';
    closeBtn.style.cursor = 'pointer';
    closeBtn.style.padding = '0';
    closeBtn.style.lineHeight = '1';
    
    // Style body
    notification.querySelector('.notification-body').style.padding = '15px';
    
    // Add close functionality
    closeBtn.addEventListener('click', () => {
        notification.remove();
    });
    
    // Add to container
    notificationContainer.appendChild(notification);
    
    // Auto-remove after 5 seconds
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 5000);
}