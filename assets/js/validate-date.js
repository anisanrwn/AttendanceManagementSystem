
document.addEventListener("DOMContentLoaded", async function () {
  const startDateInput = document.getElementById("start_date");
  const endDateInput = document.getElementById("end_date");

  const currentYear = new Date().getFullYear();
  let holidays = [];

  try {
    const response = await fetch(`https://dayoffapi.vercel.app/api?year=${currentYear}`);
    if (response.ok) {
      const data = await response.json();
      holidays = data.map(item => item.tanggal);
    } else {
      console.error("Failed to fetc");
    }
  } catch (error) {
    console.error("Error fetch holiday API:", error);
  }

  function isDisabledDate(dateStr) {
    const date = new Date(dateStr);
    const day = date.getDay(); 
    return day === 0 || day === 6 || holidays.includes(dateStr);
  }

  function showPopup() {
    Swal.fire({
      icon: 'warning',
      title: 'Date Unavailable!',
      text: 'This date falls on a national holiday or weekend.',
      confirmButtonText: 'OK'
    });
  }

  function validateDate(input) {
    const dateStr = input.value;
    if (isDisabledDate(dateStr)) {
      showPopup();
      input.value = "";
    }
  }

  startDateInput.addEventListener("change", function () {
    validateDate(this);
  });

  endDateInput.addEventListener("change", function () {
    validateDate(this);
  });
});

