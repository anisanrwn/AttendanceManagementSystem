async function fetchAttendance() {
  const employeeId = sessionStorage.getItem('employee_id');

  try {
    const response = await fetch(`http://localhost:8000/attendance/recap?employee_id=${employeeId}`);
    if (!response.ok) throw new Error("Failed to fetch attendance data");
    
    const data = await response.json();
    const attendance = data.attendance || [];
    
    const tableBody = document.getElementById("attendanceTable").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';
    
    attendance.forEach(record => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td class="text-center">${record.date || '-'}</td>
        <td class="text-center">
          ${record.late === 0 ? '<span class="badge bg-success">On Time</span>' 
            : record.late ? `<span class="badge bg-warning" onclick="Swal.fire('Late Duration', '${formatDuration(record.late)}', 'info')">Late</span>`
            : '-'}
        </td>
        <td class="text-center">${record.attendance_status || '-'}</td>
        <td class="text-center">${record.punch_in || '-'}</td>
        <td class="text-center">${record.punch_out || '-'}</td>
        <td class="text-center">
          ${record.totalHours !== null && record.totalHours !== undefined ? formatDuration(record.totalHours): '-'}
        </td>
        <td class="text-center">
          ${record.overtime !== null && record.overtime !== undefined ? formatDuration(record.overtime) : '-'}
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

filterStatus.addEventListener('change', filterPersonalAttendance);
filterMonth.addEventListener('change', filterPersonalAttendance);
filterYear.addEventListener('change', filterPersonalAttendance);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
  filterStatus.value = '';
  filterMonth.value = '';
  filterYear.value = '';
  filterPersonalAttendance();
});

function populatePersonalFilters() {
  const rows = document.querySelectorAll('#attendanceTable tbody tr');
  const statusSet = new Set();
  const monthSet = new Set();
  const yearSet = new Set();

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const status = row.cells[1].textContent.trim().toLowerCase();

    const date = new Date(dateText);
    if (!isNaN(date)) {
      const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
      const rowYear = date.getFullYear().toString();
      monthSet.add(rowMonth);
      yearSet.add(rowYear);
    }

    if (status) {
      statusSet.add(status);
    }
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

  addOptions(filterStatus, [...statusSet].sort(), 'Select Status');
  addOptions(filterMonth, [...monthSet].sort(), 'Select Month');
  addOptions(filterYear, [...yearSet].sort(), 'Select Year');
}

function filterPersonalAttendance() {
  const selectedStatus = filterStatus.value.toLowerCase();
  const selectedMonth = filterMonth.value;
  const selectedYear = filterYear.value;

  const rows = document.querySelectorAll('#attendanceTable tbody tr');

    rows.forEach(row => {
      const dateText = row.cells[0].textContent.trim().split(' ')[0];
      const status = row.cells[1].textContent.toLowerCase();
        
      const date = new Date(dateText);
      const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
      const rowYear = date.getFullYear().toString();

      const matchesStatus = selectedStatus === '' || status === selectedStatus;
      const matchesMonth = selectedMonth === '' || rowMonth === selectedMonth;
      const matchesYear = selectedYear === '' || rowYear === selectedYear;

      if (matchesStatus && matchesMonth && matchesYear) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}
