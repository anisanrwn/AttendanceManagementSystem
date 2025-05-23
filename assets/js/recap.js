document.addEventListener('DOMContentLoaded', () => {
  // Cek ada tabel attendance user gak
  if (document.getElementById('attendanceTable')) {
    fetchAttendance();
  }

  // Cek ada tabel attendance admin gak
  if (document.getElementById('allAttendanceTable')) {
    fetchAllAttendance();
  }
});

async function fetchAttendance() {
  const employeeId = sessionStorage.getItem('employee_id');
async function fetchAttendance() {
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
        <td class="text-center">${record.punch_in || '-'}</td>
        <td class="text-center">${record.punch_out || '-'}</td>
        <td class="text-center">${record.totalHours || '-'}</td>
        <td class="text-center">${record.late !== null && record.late !== undefined ? record.late + ' mins' : '-'}</td>
        <td class="text-center">${record.overtime !== null && record.overtime !== undefined ? record.overtime + ' mins' : '-'}</td>
      `;
      tableBody.appendChild(row);
    });
  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

fetchAttendance();
}

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
        const punchInArea = record.clock_in_reason? 'Outside': (record.clock_in_lat !== null && record.clock_in_lng !== null) ? 'Inside' : 'None';
        const punchOutArea = record.clock_out_reason? 'Outside' : (record.clock_out_lat !== null && record.clock_out_lng !== null) ? 'Inside': 'None';
        
        const row = document.createElement("tr");
        row.innerHTML = `
            <td class="text-center">${record.attendance_date || '-'}</td>
            <td class="text-center">${name}</td>
            <td class="text-center">${record.attendance_status || '-'}</td>
            <td class="text-center">${record.clock_in || '-'}</td>
            <td class="text-center">
              <span class="badge ${punchInArea === 'Inside' ? 'bg-success' : punchInArea === 'Outside' ? 'bg-danger' : 'bg-secondary' }">${punchInArea}</span>
            </td>
            <td class="text-center">${record.clock_in_reason || '-'}</td>
            <td class="text-center">${record.clock_out || '-'}</td>
            <td class="text-center">
              <span class="badge ${punchOutArea === 'Inside' ? 'bg-success' : punchOutArea === 'Outside' ? 'bg-danger' : 'bg-secondary' }">${punchOutArea}</span>
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
  } catch (error) {
    console.error("Error fetching attendance:", error);
  }
}

fetchAllAttendance();

const exportBtn = document.getElementById('exportButton');
if (exportBtn) {
  exportBtn.addEventListener('click', function() {
    let tableId = document.getElementById('allAttendanceTable') ? 'allAttendanceTable' : 'attendanceTable';
    var table = document.getElementById(tableId);
    var wb = XLSX.utils.table_to_book(table, {sheet: "Attendance"});
    XLSX.writeFile(wb, 'Attendance.xlsx');
  });
}
