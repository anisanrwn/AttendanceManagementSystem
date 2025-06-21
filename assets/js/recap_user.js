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

const filterLate = document.getElementById('filterLate');
const filterStatus = document.getElementById('filterStatus');
const filterMonth = document.getElementById('filterMonth');
const filterYear = document.getElementById('filterYear');

let debounceTimer;
const debounce = (callback, delay) => {
    return (...args) => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => callback(...args), delay);
    };
};

filterLate.addEventListener('change', filterPersonalAttendance);
filterStatus.addEventListener('change', filterPersonalAttendance);
filterMonth.addEventListener('change', filterPersonalAttendance);
filterYear.addEventListener('change', filterPersonalAttendance);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
  filterLate.value = '';
  filterStatus.value = '';
  filterMonth.value = '';
  filterYear.value = '';
  filterPersonalAttendance();
});

function populatePersonalFilters() {
  const rows = document.querySelectorAll('#attendanceTable tbody tr');
  const lateSet = new Set();
  const statusSet = new Set();
  const monthSet = new Set();
  const yearSet = new Set();

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const late = row.cells[1].textContent.trim().toLowerCase();
    const status = row.cells[2].textContent.trim().toLowerCase();

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

function filterPersonalAttendance() {
  const selectedLate = filterLate.value.toLowerCase(); 
  const selectedStatus = filterStatus.value.toLowerCase(); 
  const selectedMonth = filterMonth.value;
  const selectedYear = filterYear.value;

  const rows = document.querySelectorAll('#attendanceTable tbody tr');

    rows.forEach(row => {
      const dateText = row.cells[0].textContent.trim().split(' ')[0];
      const late = row.cells[1].textContent.trim().toLowerCase();
      const status = row.cells[2].textContent.trim().toLowerCase();
      const date = new Date(dateText);
      const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
      const rowYear = date.getFullYear().toString();
      const matchesLate = selectedLate === '' || late === selectedLate;
      const matchesStatus = selectedStatus === '' || status === selectedStatus;
      const matchesMonth = selectedMonth === '' || rowMonth === selectedMonth;
      const matchesYear = selectedYear === '' || rowYear === selectedYear;

      if (matchesLate && matchesStatus && matchesMonth && matchesYear) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}
