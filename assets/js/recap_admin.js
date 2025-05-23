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
        <td class="text-center">${record.attendance_status || '-'}</td>
        <td class="text-center">${record.punch_in || '-'}</td>
        <td class="text-center">${record.punch_out || '-'}</td>
        <td class="text-center">${record.totalHours || '-'}</td>
        <td class="text-center">${record.late !== null && record.late !== undefined ? record.late + ' mins' : '-'}</td>
        <td class="text-center">${record.overtime !== null && record.overtime !== undefined ? record.overtime + ' mins' : '-'}</td>
      `;
      tableBody.appendChild(row);
    });
    populateFilters();
  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

fetchAttendance();


async function fetchAllAttendance() {
  try {
    const response = await fetch("http://localhost:8000/attendance/recap/all");
    if (!response.ok) throw new Error("Failed to fetch attendance data");

    const data = await response.json();
    const attendance = data.attendance || [];

    const tableBody = document.getElementById("allAttendanceTable").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';

    attendance.forEach(record => {
      const name = record.employee_name || '-';
      const punchInArea = record.clock_in_reason ? 'Outside' : (record.clock_in_lat !== null && record.clock_in_lng !== null) ? 'Inside' : 'None';
      const punchOutArea = record.clock_out_reason ? 'Outside' : (record.clock_out_lat !== null && record.clock_out_lng !== null) ? 'Inside' : 'None';

      const row = document.createElement("tr");
      row.innerHTML = `
          <td class="text-center">${record.attendance_date || '-'}</td>
          <td class="text-center">${name}</td>
          <td class="text-center">${record.attendance_status || '-'}</td>
          <td class="text-center">${record.clock_in || '-'}</td>
          <td class="text-center">
            <span class="badge ${punchInArea === 'Inside' ? 'bg-success' : punchInArea === 'Outside' ? 'bg-danger' : 'bg-secondary'}">${punchInArea}</span>
          </td>
          <td class="text-center">${record.clock_in_reason || '-'}</td>
          <td class="text-center">${record.clock_out || '-'}</td>
          <td class="text-center">
            <span class="badge ${punchOutArea === 'Inside' ? 'bg-success' : punchOutArea === 'Outside' ? 'bg-danger' : 'bg-secondary'}">${punchOutArea}</span>
          </td>
          <td class="text-center">${record.clock_out_reason || '-'}</td>
          <td class="text-center">
            <span class="badge ${record.face_verified ? 'bg-success' : 'bg-secondary'}">
                ${record.face_verified ? 'Yes' : 'No'}
            </span>
          </td>
          <td class="text-center">${record.totalHours || '-'}</td>
          <td class="text-center">${record.late !== null && record.late !== undefined ? record.late + ' mins' : '-'}</td>
          <td class="text-center">${record.overtime !== null && record.overtime !== undefined ? record.overtime + ' mins' : '-'}</td>
      `;
      tableBody.appendChild(row);
    });
    populateFilters();

  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
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
filterStatus.addEventListener('change', filterAttendance);
filterMonth.addEventListener('change', filterAttendance);
filterYear.addEventListener('change', filterAttendance);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
  searchInput.value = '';
  filterStatus.value = '';
  filterMonth.value = '';
  filterYear.value = '';
  filterAttendance();
});

function populateFilters() {
  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');
  const statusSet = new Set();
  const monthSet = new Set();
  const yearSet = new Set();

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const status = row.cells[2].textContent.trim().toLowerCase();

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

function filterAttendance() {
  const searchValue = searchInput.value.toLowerCase();
  const selectedStatus = filterStatus.value.toLowerCase();
  const selectedMonth = filterMonth.value;
  const selectedYear = filterYear.value;

  const rows = document.querySelectorAll('#allAttendanceTable tbody tr');

  rows.forEach(row => {
    const dateText = row.cells[0].textContent.trim().split(' ')[0];
    const name = row.cells[1].textContent.toLowerCase();
    const status = row.cells[2].textContent.toLowerCase();

    const date = new Date(dateText);
    const rowMonth = (date.getMonth() + 1).toString().padStart(2, '0');
    const rowYear = date.getFullYear().toString();

    const matchesSearch = name.includes(searchValue);
    const matchesStatus = selectedStatus === '' || status === selectedStatus;
    const matchesMonth = selectedMonth === '' || rowMonth === selectedMonth;
    const matchesYear = selectedYear === '' || rowYear === selectedYear;

    if (matchesSearch && matchesStatus && matchesMonth && matchesYear) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  });
}
