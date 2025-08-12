let capturedImages = [];
let stepIndex = 0;
let stream = null;

const videoPreview = document.getElementById("videoPreview");
const captureBtn = document.getElementById("captureBtn");
const finishBtn = document.getElementById("finishBtn");
const captureStep = document.getElementById("captureStep");
const captureInstruction = document.getElementById("captureInstruction");
const capturedPreview = document.getElementById("capturedPreview");
const BLANK_IMG = "data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=";

const thumbs = [
    document.getElementById("thumb1"),
    document.getElementById("thumb2"),
    document.getElementById("thumb3"),
    document.getElementById("thumb4"),
];
const instructions = [
    "Look Straight at the Camera",
    "Turn Head to the Right",
    "Turn Head to the Left",
    "Smile at the Camera",
];

const captureModal = document.getElementById("captureFaceModal");
captureModal.addEventListener("show.bs.modal", () => {
    resetCapture();
});

document.getElementById("captureFaceModal").addEventListener("shown.bs.modal", async () => {
    resetCapture();
    try {
        stream = await navigator.mediaDevices.getUserMedia({ video: true });
        videoPreview.srcObject = stream;
    } catch (err) {
        Swal.fire("Error", "Cannot access camera: " + err.message, "error");
    }
});

document.getElementById("captureFaceModal").addEventListener("hidden.bs.modal", () => {
    stopStream();
});

document.getElementById("addEmployeeModal").addEventListener("hidden.bs.modal", () => {
    resetCapture();
});

captureBtn.addEventListener("click", () => {
    if (stepIndex >= 4) {
        resetCapture();
        return;
    }

    const canvas = document.createElement("canvas");
    canvas.width = videoPreview.videoWidth;
    canvas.height = videoPreview.videoHeight;

    const ctx = canvas.getContext("2d");
    ctx.drawImage(videoPreview, 0, 0, canvas.width, canvas.height);

    const dataURL = canvas.toDataURL("image/jpeg");
    capturedImages.push(dataURL);
    thumbs[stepIndex].src = dataURL;

    stepIndex++;
    updateStepUI();

    if (stepIndex === 4) {
        captureBtn.classList.remove("btn-primary");
        captureBtn.classList.add("btn-warning");
        captureBtn.textContent = "Retake?";
        finishBtn.classList.remove("d-none");
    }
});

finishBtn.addEventListener("click", () => {
    updatePreviewInForm();
    $('#captureFaceModal').modal('hide');
    $('#captureFaceModal').on('hidden.bs.modal', function () {
        $("#addEmployeeModal").modal("show");
        $('#captureFaceModal').off('hidden.bs.modal');
    });
});

async function isNrpAvail(nrp) {
    const res = await fetch(`http://localhost:8000/employee/check_nrp/${nrp}`);
    const data = await res.json();
    return data.available;
}

async function isPhoneAvail(phone) {
    const res = await fetch(`http://localhost:8000/employee/check_phone/${phone}`);
    const data = await res.json();
    return data.available;
}

// Submit form
document.getElementById('submit').addEventListener('click', saveEmployee);
async function saveEmployee(e) {
    e.preventDefault();

    const firstName = document.getElementById('first_name').value.trim();
    const lastName = document.getElementById('last_name').value.trim();
    const nrp = document.getElementById('nrp_id').value.trim();
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone_number').value.trim();
    const position = document.getElementById('position').value.trim();
    const department = document.getElementById('department').value.trim();
    const joinDate = document.getElementById('join_date').value.trim();
    const nrpAvailable = await isNrpAvail(nrp);
    const phoneAvailable = await isPhoneAvail(phone);
    const emailAvailable = await isEmailAvail(email);
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^08[0-9]{8,11}$/;

    if (!firstName || !lastName || !email || !phone || !nrp || !position || !department || !joinDate) {
        Swal.fire('Error!', 'Please fill in all required fields.', 'error');
        return;
    }

    if (!emailRegex.test(email)) {
        Swal.fire('Error!', 'Please enter a valid email address.', 'error');
        return;
    }

    if (!emailAvailable) {
        Swal.fire('Error!', 'Email already exists.', 'error');
        return;
    }

    if (!phoneRegex.test(phone)) {
        Swal.fire('Error!', 'Phone number must start with 08 and contain 10–13 digits.', 'error');
        return;
    }

    if (nrp.length !== 9) {
        Swal.fire('Error!', 'NRP must be exactly 9 digits.', 'error');
        return;
    }
    if (!nrpAvailable) {
        Swal.fire('Error!', 'NRP already exists.', 'error');
        return;
    }

    if (!phoneAvailable) {
        Swal.fire('Error!', 'Phone number already exists.', 'error');
        return;
    }
    if (capturedImages.length < 4) {
        Swal.fire("Error!", "Please capture 4 face images first.", "error");
        return;
    }

    const formData = new FormData(employeeForm);
    formData.delete("photo"); 

    capturedImages.forEach((imgData, idx) => {
        const blob = dataURLtoBlob(imgData);
        console.log('Captured Images:', capturedImages.length);
        formData.append("files", blob, `face_${idx + 1}.jpg`);
    });

    const token = localStorage.getItem('token');

    try {
        $('#addEmployeeModal').modal('hide');
        Swal.fire({
            title: 'Registering...',
            text: 'Please wait while we save the employee data.',
            allowOutsideClick: false,
            didOpen: () => Swal.showLoading()
        });

        const response = await fetch("http://localhost:8000/employee/add", {
            method: "POST",
            headers: { "Authorization": `Bearer ${token}` },
            body: formData
        });

        let data;
        try {
            data = await response.json();
            console.log("Parsed JSON:", data);
        } catch (err) {
            const text = await response.text();
            console.error("Failed to parse JSON. Raw response:", text);
            console.error("Error object:", err);
            Swal.fire("Error!", "Server returned non-JSON response", "error");
            return;
        }


        if (response.ok) {
            Swal.fire({
                title: 'Success!',
                text: 'Employee registered successfully!',
                icon: 'success',
                timer: 1500,
                showConfirmButton: false
            });
            
            employeeForm.reset();
            capturedImages = [];
            fetchEmployees();

        } else {
            let errorMsg = 'Failed to register employee.';
            try {
                const errorData = await response.json();
                if (typeof errorData.detail === 'string') {
                    errorMsg = errorData.detail;
                } else if (Array.isArray(errorData.detail)) {
                    errorMsg = errorData.detail.map(d => d.msg || JSON.stringify(d)).join('<br>');
                } else if (typeof errorData.detail === 'object' && errorData.detail !== null) {
                    errorMsg = JSON.stringify(errorData.detail);
                }
            } catch (e) {
                errorMsg = 'Unexpected server error.';
            }

            Swal.fire('Error!', errorMsg, 'error'); 
        }

    } catch (err) {
        Swal.fire('Error!', 'Something went wrong. Please try again later.', 'error');
    }
}

// Utility
function updateStepUI() {
    captureStep.textContent = `Step ${stepIndex + 1} of 4`;
    captureInstruction.textContent = instructions[stepIndex] || "Done!";
}

function updatePreviewInForm() {
    capturedPreview.innerHTML = "";
    capturedImages.forEach((imgData) => {
        const img = document.createElement("img");
        img.src = imgData;
        img.width = 70;
        img.height = 70;
        img.classList.add("rounded", "border");
        capturedPreview.appendChild(img);
    });
}

function dataURLtoBlob(dataURL) {
    const arr = dataURL.split(",");
    const mime = arr[0].match(/:(.*?);/)[1];
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);
    while (n--) u8arr[n] = bstr.charCodeAt(n);
    return new Blob([u8arr], { type: mime });
}

function stopStream() {
    if (stream) {
        stream.getTracks().forEach(track => track.stop());
        stream = null;
    }
}

function resetCapture() {
    capturedImages = [];
    stepIndex = 0;
    captureBtn.classList.remove("d-none", "btn-warning");
    captureBtn.classList.add("btn-primary");
    captureBtn.textContent = "Capture";
    finishBtn.classList.add("d-none");

    thumbs.forEach(thumb => {
        thumb.src = BLANK_IMG;
    });
    updateStepUI();
}

function resetCaptureAndForm() {
    resetCapture();
    employeeForm.reset();
    capturedPreview.innerHTML = "";
}