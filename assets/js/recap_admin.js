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

    populateFilters();

  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

// Area Badge Class Generator
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
const filterMonth = document.getElementById('filterAdminMonth');
const filterYear = document.getElementById('filterAdminYear');

let debounceTimer;
const debounce = (callback, delay) => {
  return (...args) => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => callback(...args), delay);
  };
};

// Event listeners
searchInput.addEventListener('input', debounce(filterAttendance, 300));
filterLate.addEventListener('change', filterAttendance);
filterStatus.addEventListener('change', filterAttendance);
filterMonth.addEventListener('change', filterAttendance);
filterYear.addEventListener('change', filterAttendance);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
  searchInput.value = '';
  filterLate.value = '';
  filterStatus.value = '';
  filterMonth.value = '';
  filterYear.value = '';
  filterAttendance();
});

function populateFilters() {
  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');
  const lateSet = new Set();
  const statusSet = new Set();
  const monthSet = new Set();
  const yearSet = new Set();

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const late = row.getAttribute("data-late");
    const status = row.getAttribute("data-status");

    const date = new Date(dateText);
    if (!isNaN(date)) {
      const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
      const rowYear = date.getFullYear().toString();
      monthSet.add(rowMonth);
      yearSet.add(rowYear);
    }

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
  addOptions(filterMonth, [...monthSet].sort(), 'Month?');
  addOptions(filterYear, [...yearSet].sort(), 'Year?');
}

function filterAttendance() {
  const searchValue = searchInput.value.toLowerCase();
  const selectedLate = filterLate.value.toLowerCase(); 
  const selectedStatus = filterStatus.value.toLowerCase(); 
  const selectedMonth = filterMonth.value;
  const selectedYear = filterYear.value;

  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const name = row.cells[1].textContent.toLowerCase();
    const late = row.getAttribute("data-late");
    const status = row.getAttribute("data-status");
    const date = new Date(dateText);
    const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
    const rowYear = date.getFullYear().toString();

    const matchesSearch = name.includes(searchValue);
    const matchesLate = selectedLate === '' || late === selectedLate;
    const matchesStatus = selectedStatus === '' || status === selectedStatus;
    const matchesMonth = selectedMonth === '' || rowMonth === selectedMonth;
    const matchesYear = selectedYear === '' || rowYear === selectedYear;

    if (matchesSearch && matchesLate && matchesStatus && matchesMonth && matchesYear)
    {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}
