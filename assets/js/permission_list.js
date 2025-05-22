document.addEventListener("DOMContentLoaded", function () {
  fetch("http://127.0.0.1:8000/permissionlist/permissions/list")
    .then(response => response.json())
    .then(data => {
      const tbody = document.getElementById("permission-body");
     data.permissions.sort((a, b) => new Date(b.request_date) - new Date(a.request_date))
     .forEach(permission => {
        const row = document.createElement("tr");

        row.innerHTML = `
          <td>${permission.employee_name}</td>
          <td>${permission.request_date}</td>
          <td>${permission.start_date}</td>
          <td>${permission.end_date}</td>
          <td>${permission.permission_type}</td>
          <td>${permission.reason}</td>
          <td class="status">${permission.permission_status}</td>
          <td class="approved-date">${permission.approved_date || '-'}</td>
          <td>
              <button class="btn btn-success btn-sm btn-rounded btn-approve" data-id="${permission.permissions_id}" ${permission.permission_status !== 'Pending' ? 'disabled' : ''}>Approve</button>
              <button class="btn btn-danger btn-sm btn-rounded btn-decline" data-id="${permission.permissions_id}" ${permission.permission_status !== 'Pending' ? 'disabled' : ''}>Decline</button>
          </td>
        `;

        tbody.appendChild(row);
      });

      document.querySelectorAll('.btn-approve').forEach(button => {
        button.addEventListener('click', function () {
          const id = this.dataset.id;
          updatePermissionStatus(id, 'Approved', this);
        });
      });

      document.querySelectorAll('.btn-decline').forEach(button => {
        button.addEventListener('click', function () {
          const id = this.dataset.id;
          updatePermissionStatus(id, 'Declined', this);
        });
      });
    })
    .catch(error => {
      console.error("Gagal memuat data:", error);
    });
});

function updatePermissionStatus(id, status, button) {
  fetch(`http://127.0.0.1:8000/permissionlist/permissions/${id}/${status.toLowerCase()}`, {
    method: 'PUT'
  })
    .then(res => {
      if (!res.ok) throw new Error("Gagal update");
      return res.json();
    })
    .then(result => {
      const row = button.closest("tr");
      row.querySelector(".status").textContent = status;
      row.querySelector(".approved-date").textContent = result.approved_date;
      row.querySelectorAll("button").forEach(btn => btn.disabled = true);
      alert(result.message);
    })
    .catch(error => {
      console.error("Error:", error);
    });
}


 document.getElementById('filterButton').addEventListener('click', function() {
    var month = document.getElementById('filterMonth').value;
    var year = document.getElementById('filterYear').value;
    var rows = document.querySelectorAll('#permission-table tbody tr');

    rows.forEach(function(row) {
      var startDateText = row.cells[1].textContent.trim(); // kolom Start Date
      var date = new Date(startDateText);
      var showRow = true;

      if (month && (String(date.getMonth() + 1).padStart(2, '0') !== month)) {
        showRow = false;
      }
      if (year && date.getFullYear().toString() !== year) {
        showRow = false;
      }

      row.style.display = showRow ? '' : 'none';
    });
});
  document.getElementById('exportButton').addEventListener('click', function() {
    var table = document.getElementById('attendanceTable');
    var wb = XLSX.utils.table_to_book(table, {sheet: "Attendance"});
    XLSX.writeFile(wb, 'Attendance.xlsx');
  });
  function handlePermission(action, employeeName) {
  let toast = document.getElementById('notificationToast');

  if (action === 'accept') {
    toast.className = 'alert alert-success';
    toast.innerText = 'Permission request accepted for ' + employeeName;
  } else if (action === 'reject') {
    toast.className = 'alert alert-danger';
    toast.innerText = 'Permission request rejected for ' + employeeName;
  }

  toast.style.display = 'block';

  // Hide after 3 seconds
  setTimeout(() => {
    toast.style.display = 'none';
  }, 3000);

  // TODO: Tambahkan AJAX request di sini kalau mau update ke database
}