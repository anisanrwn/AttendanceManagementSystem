async function fetchAttendance() {
  const employeeId = sessionStorage.getItem('employee_id');

  try {
    const response = await fetch(`http://localhost:8000/attendance/recap?employee_id=${employeeId}`);
    if (!response.ok) throw new Error("Failed to fetch attendance data");
    
    const data = await response.json();
    const attendance = data.attendance || [];
    const holidays = data.holidays || [];
    
    const tableBody = document.getElementById("attendanceTable").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';
    
    attendance.forEach(record => {
      const {
        attendance_date, late, attendance_status, clock_in, clock_out, totalHours, overtime 
      } = record;
      const status = attendance_status || '-';
      const dateObj = new Date(attendance_date);
      const isWeekend = dateObj.getDay() === 0 || dateObj.getDay() === 6;
      const isHoliday = holidays.includes(attendance_date);
      const isHolidayOrWeekend = isWeekend || isHoliday;
      let statusBadgeClass = 'bg-secondary';
      switch (status.toLowerCase()) {
        case 'punch in': statusBadgeClass = 'bg-label-primary'; break;
        case 'punch out': statusBadgeClass = 'bg-label-primary'; break;
        case 'permit': statusBadgeClass = 'bg-label-info'; break;
        case 'holiday':
        case 'weekend': statusBadgeClass = 'bg-label-danger'; break;
        case 'absent': statusBadgeClass = 'bg-label-secondary'; break;
      }
      const dateStyle = isHolidayOrWeekend ? 'style="color:red; font-weight:bold"' : '';
      const row = document.createElement("tr");

      row.innerHTML = `
        <td class="text-center" ${dateStyle}>${attendance_date || '-'}</td>
        <td class="text-center">
          ${late === 0 ? '<span class="badge bg-label-success">On Time</span>' 
            : late ? `<span class="badge bg-label-danger" onclick="Swal.fire('Late Duration', '${formatDuration(late)}', 'info')">Late</span>`
            : '-'}
        </td>
        <td class="text-center">
          <span class="badge badge-label ${statusBadgeClass}">${status}</span>
        </td>
        <td class="text-center">${clock_in || '-'}</td>
        <td class="text-center">${clock_out || '-'}</td>
        <td class="text-center">
          ${totalHours !== null && totalHours !== undefined ? formatDuration(totalHours): '-'}
        </td>
        <td class="text-center">
          ${overtime !== null && overtime !== undefined ? formatDuration(overtime) : '-'}
        </td>
      `;
      tableBody.appendChild(row);
    });
    updateSummary();
    populatePersonalFilters();
  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

fetchAttendance();

function formatDuration(seconds) {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = Math.floor(seconds % 60);

  return `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
}

function updateSummary() {
  const rows = document.querySelectorAll("#attendanceTable tbody tr:not([style*='display: none'])");

  let totalPunchOut = 0;
  let totalPermit = 0;
  let totalAbsent = 0;
  let totalLate = 0;

  rows.forEach(row => {
    const cols = row.querySelectorAll("td");
    const lateText = cols[1]?.textContent.trim().toLowerCase();
    const status = cols[2]?.textContent.trim().toLowerCase();
    const punchOut = cols[4]?.textContent.trim();

    if (punchOut && punchOut !== "-") totalPunchOut++;
    if (status.includes("permit")) totalPermit++;
    if (status.includes("absent")) totalAbsent++;
    if (lateText.includes("late")) totalLate++;
  });

  document.getElementById("summaryPunchOut").textContent = totalPunchOut;
  document.getElementById("summaryPermit").textContent = totalPermit;
  document.getElementById("summaryAbsent").textContent = totalAbsent;
  document.getElementById("summaryLate").textContent = totalLate;
}


const filterLate = document.getElementById('filterLate');
const filterStatus = document.getElementById('filterStatus');
const filterFromDate = document.getElementById('filterFromDate');
const filterToDate = document.getElementById('filterToDate');

let debounceTimer;
const debounce = (callback, delay) => {
    return (...args) => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => callback(...args), delay);
    };
};

filterLate.addEventListener('change', filterPersonalAttendance);
filterStatus.addEventListener('change', filterPersonalAttendance);
filterFromDate.addEventListener('change', filterPersonalAttendance);
filterToDate.addEventListener('change', filterPersonalAttendance);


document.getElementById('clearFiltersButton').addEventListener('click', () => {
  filterLate.value = '';
  filterStatus.value = '';
  filterFromDate.value = '';
  filterToDate.value = '';
  filterFromDate.type = 'text';
  filterToDate.type = 'text';
  filterPersonalAttendance();
});

function populatePersonalFilters() {
  const rows = document.querySelectorAll('#attendanceTable tbody tr');
  const lateSet = new Set();
  const statusSet = new Set();

  rows.forEach(row => {
    const late = row.cells[1].textContent.trim().toLowerCase();
    const status = row.cells[2].textContent.trim().toLowerCase();

    if (late) lateSet.add(late);
    if (status) statusSet.add(status);
  });

  const addOptions = (selectEl, values, label) => {
    selectEl.innerHTML = `<option value="">${label}</option>`;
    values.forEach(value => {
      const option = document.createElement('option');
      option.value = value;
      option.textContent = value.charAt(0).toUpperCase() + value.slice(1);
      selectEl.appendChild(option);
    });
  };

  addOptions(filterLate, [...lateSet].sort(), 'Late?');
  addOptions(filterStatus, [...statusSet].sort(), 'Status?');
}

function filterPersonalAttendance() {
  const selectedLate = filterLate.value.toLowerCase(); 
  const selectedStatus = filterStatus.value.toLowerCase(); 
  const fromDate = filterFromDate.value ? new Date(filterFromDate.value) : null;
  const toDate = filterToDate.value ? new Date(filterToDate.value) : null;

  const rows = document.querySelectorAll('#attendanceTable tbody tr');

  rows.forEach(row => {
    const late = row.cells[1].textContent.trim().toLowerCase();
    const status = row.cells[2].textContent.trim().toLowerCase();

    const dateText = row.cells[0].textContent.trim();
    const rowDate = new Date(dateText);

    const matchesLate = selectedLate === '' || late === selectedLate;
    const matchesStatus = selectedStatus === '' || status === selectedStatus;

    let matchesDate = true;
    if (fromDate && rowDate < fromDate) matchesDate = false;
    if (toDate && rowDate > toDate) matchesDate = false;

    row.style.display = (matchesLate && matchesStatus && matchesDate) ? '' : 'none';
  });

  updateSummary();
}
