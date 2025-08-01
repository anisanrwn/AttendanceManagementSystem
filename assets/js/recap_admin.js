fetchAllAttendance();

async function fetchAllAttendance() {
  try {
    const response = await fetch("http://localhost:8000/attendance/recap/all");
    if (!response.ok) throw new Error("Failed to fetch attendance data");

    const data = await response.json();
    const attendance = data.attendance || [];
    const holidays = data.holidays || [];

    const tableBody = document.getElementById("allAttendanceTable").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';

    attendance.forEach(record => {
      const {
        attendance_date, employee_name, late, attendance_status, clock_in, clock_out, clock_in_lat, clock_in_lng, clock_in_reason, clock_out_lat, clock_out_lng, clock_out_reason, totalHours,  overtime 
      } = record;

      const name = employee_name || '-';
      const status = attendance_status || '-';
      const dateObj = new Date(attendance_date);
      const isWeekend = dateObj.getDay() === 0 || dateObj.getDay() === 6;
      const isHoliday = holidays.includes(attendance_date);
      const isHolidayOrWeekend = isWeekend || isHoliday;
      const punchInArea = clock_in_reason ? 'Outside' :
                          (clock_in_lat !== null && clock_in_lng !== null) ? 'Inside' : 'None';
      const punchOutArea = clock_out_reason ? 'Outside' :
                           (clock_out_lat !== null && clock_out_lng !== null) ? 'Inside' : 'None';
      let statusBadgeClass = 'bg-secondary';
      switch (status.toLowerCase()) {
        case 'punch in': statusBadgeClass = 'bg-label-primary'; break;
        case 'punch out': statusBadgeClass = 'bg-label-primary'; break;
        case 'permit': statusBadgeClass = 'bg-label-info'; break;
        case 'holiday':
        case 'weekend': statusBadgeClass = 'bg-label-danger'; break;
        case 'absent': statusBadgeClass = 'bg-label-secondary'; break;
      }

      const dateStyle = isHolidayOrWeekend ? 'style="color:red;"' : '';
      const row = document.createElement("tr");
      row.setAttribute("data-late", late === 0 ? "on time" : late ? "late" : "none");
      row.setAttribute("data-status", status.toLowerCase());

      row.innerHTML = `
        <td class="text-center" ${dateStyle}>${attendance_date || '-'}</td>
        <td class="text-center">${name}</td>
        <td class="text-center">
          ${late === 0 ? '<span class="badge bg-label-success">On Time</span>' 
            : late ? `<span class="badge bg-label-danger" onclick="Swal.fire('Late Duration', '${formatDuration(late)}', 'info')">Late</span>`
            : '-'}
        </td>
        <td class="text-center">
          <span class="badge badge-label ${statusBadgeClass}">${status}</span>
        </td>
        <td class="text-center">${clock_in || '-'}</td>
        <td class="text-center">
           ${punchInArea !== 'None' && clock_in_lat && clock_in_lng
            ? `<a href="https://www.google.com/maps?q=${clock_in_lat},${clock_in_lng}" target="_blank">
                <span class="badge ${getAreaClass(punchInArea)}" style="cursor:pointer">${punchInArea}</span>
              </a>`
            : `<span class="badge ${getAreaClass(punchInArea)}">${punchInArea}</span>`}
        </td>
        <td class="text-center">${clock_in_reason || '-'}</td>
        <td class="text-center">${clock_out || '-'}</td>
        <td class="text-center">
           ${punchOutArea !== 'None' && clock_out_lat && clock_out_lng
            ? `<a href="https://www.google.com/maps?q=${clock_out_lat},${clock_out_lng}" target="_blank">
                <span class="badge ${getAreaClass(punchOutArea)}" style="cursor:pointer">${punchOutArea}</span>
              </a>`
            : `<span class="badge ${getAreaClass(punchOutArea)}">${punchOutArea}</span>`}
        </td>
        <td class="text-center">${clock_out_reason || '-'}</td>
        <td class="text-center">
          ${totalHours !== null && totalHours !== undefined ? formatDuration(totalHours) : '-'}
        </td>
        <td class="text-center">
          ${overtime !== null && overtime !== undefined ? formatDuration(overtime) : '-'}
        </td>
      `;

      tableBody.appendChild(row);
    });
    updateSummary();
    populateFilters();

  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

function getAreaClass(area) {
  switch (area) {
    case 'Inside': return 'bg-label-success';
    case 'Outside': return 'bg-label-danger';
    default: return 'bg-label-secondary';
  }
}

function formatDuration(seconds) {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = Math.floor(seconds % 60);

  return `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
}

function updateSummary() {
  const rows = document.querySelectorAll("#allAttendanceTable tbody tr:not([style*='display: none'])");

  let totalPunchOut = 0;
  let totalPermit = 0;
  let totalAbsent = 0;
  let totalLate = 0;

  let clockInInside = 0;
  let clockInOutside = 0;
  let clockOutInside = 0;
  let clockOutOutside = 0;

  rows.forEach(row => {
    const cols = row.querySelectorAll("td");

    const lateText = cols[2]?.textContent.trim().toLowerCase();
    const status = cols[3]?.textContent.trim().toLowerCase();
    const punchOut = cols[7]?.textContent.trim();
    const punchInArea = cols[5]?.textContent.trim().toLowerCase();
    const punchOutArea = cols[8]?.textContent.trim().toLowerCase();

    if (punchOut && punchOut !== "-") totalPunchOut++;
    if (status.includes("permit")) totalPermit++;
    if (status.includes("absent")) totalAbsent++;
    if (lateText.includes("late")) totalLate++;
    if (punchInArea.includes("inside")) clockInInside++;
    if (punchInArea.includes("outside")) clockInOutside++;
    if (punchOutArea.includes("inside")) clockOutInside++;
    if (punchOutArea.includes("outside")) clockOutOutside++;
  });

  document.getElementById("summaryPunchOut").textContent = totalPunchOut;
  document.getElementById("summaryPermit").textContent = totalPermit;
  document.getElementById("summaryAbsent").textContent = totalAbsent;
  document.getElementById("summaryLate").textContent = totalLate;
  document.getElementById("clockInInside").textContent = clockInInside;
  document.getElementById("clockInOutside").textContent = clockInOutside;
  document.getElementById("clockOutInside").textContent = clockOutInside;
  document.getElementById("clockOutOutside").textContent = clockOutOutside;
}

const exportBtn = document.getElementById('exportButton');
if (exportBtn) {
  exportBtn.addEventListener('click', function() {
    let tableId = document.getElementById('allAttendanceTable') ? 'allAttendanceTable' : 'attendanceTable';
    var table = document.getElementById(tableId);
    var wb = XLSX.utils.table_to_book(table, {sheet: "Attendance"});
    XLSX.writeFile(wb, 'Attendance.xlsx');
  });
}

const searchInput = document.getElementById('searchAttendanceName');
const filterLate = document.getElementById('filterAdminLate');
const filterStatus = document.getElementById('filterAdminStatus');
const filterFromDate = document.getElementById('filterFromDate');
const filterToDate = document.getElementById('filterToDate');

let debounceTimer;
const debounce = (callback, delay) => {
  return (...args) => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => callback(...args), delay);
  };
};

searchInput.addEventListener('input', debounce(filterAttendance, 300));
filterLate.addEventListener('change', filterAttendance);
filterStatus.addEventListener('change', filterAttendance);
filterFromDate.addEventListener('change', filterAttendance);
filterToDate.addEventListener('change', filterAttendance);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
  searchInput.value = '';
  filterLate.value = '';
  filterStatus.value = '';
  filterFromDate.value = '';
  filterToDate.value = '';
  filterFromDate.type = 'text';
  filterToDate.type = 'text';
  filterAttendance();
});

function populateFilters() {
  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');
  const lateSet = new Set();
  const statusSet = new Set();

  rows.forEach(row => {
    const late = row.getAttribute("data-late");
    const status = row.getAttribute("data-status");

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

function filterAttendance() {
  const searchValue = searchInput.value.toLowerCase();
  const selectedLate = filterLate.value.toLowerCase(); 
  const selectedStatus = filterStatus.value.toLowerCase(); 
  const fromDate = filterFromDate.value ? new Date(filterFromDate.value) : null;
  const toDate = filterToDate.value ? new Date(filterToDate.value) : null;

  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const rowDate = new Date(dateText);

    const name = row.cells[1].textContent.toLowerCase();
    const late = row.getAttribute("data-late");
    const status = row.getAttribute("data-status");

    const matchesSearch = name.includes(searchValue);
    const matchesLate = selectedLate === '' || late === selectedLate;
    const matchesStatus = selectedStatus === '' || status === selectedStatus;

    let matchesDate = true;
    if (fromDate && rowDate < fromDate) matchesDate = false;
    if (toDate && rowDate > toDate) matchesDate = false;

    row.style.display = (matchesSearch && matchesLate && matchesStatus && matchesDate) ? '' : 'none';
  });
  updateSummary();
}
