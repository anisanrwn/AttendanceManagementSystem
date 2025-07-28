let allPermissions = []; // Untuk menyimpan semua data izin

document.addEventListener("DOMContentLoaded", function () {
  fetch("http://127.0.0.1:8000/permissionlist/permissions/list")
    .then(response => response.json())
    .then(data => {
      allPermissions = data.permissions.sort((a, b) => new Date(b.request_date) - new Date(a.request_date));
      renderTable(allPermissions);

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

  // Filter status
  document.getElementById('filterStatus').addEventListener('change', function () {
    const selectedStatus = this.value;
    const filtered = selectedStatus === "All" 
      ? allPermissions 
      : allPermissions.filter(p => p.permission_status === selectedStatus);
    renderTable(filtered);
  });

  // Filter bulan/tahun otomatis tanpa tombol cari
  document.getElementById('filterMonth').addEventListener('change', applyMonthYearFilter);
  document.getElementById('filterYear').addEventListener('change', applyMonthYearFilter);
});

function applyMonthYearFilter() {
  const month = document.getElementById('filterMonth').value;
  const year = document.getElementById('filterYear').value;

  const filtered = allPermissions.filter(permission => {
    const date = new Date(permission.request_date);
    return (!month || (String(date.getMonth() + 1).padStart(2, '0') === month)) &&
           (!year || (date.getFullYear().toString() === year));
  });

  renderTable(filtered);
}

function renderTable(data) {
  const tbody = document.getElementById("permission-body");
  tbody.innerHTML = ""; // Clear isi tabel sebelum render ulang

  data.forEach(permission => {
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

  // Re-attach event listeners setelah render ulang
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
}

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

      // SweetAlert muncul setelah update berhasil
      Swal.fire({
        icon: status === 'Approved' ? 'success' : 'error',
        title: result.message,
        showConfirmButton: false,
        timer: 2000
      });

      // Update data lokal
      const index = allPermissions.findIndex(p => p.permissions_id == id);
      if (index !== -1) {
        allPermissions[index].permission_status = status;
        allPermissions[index].approved_date = result.approved_date;
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
}


document.getElementById('exportButton').addEventListener('click', function () {
  const table = document.getElementById('attendanceTable');
  const wb = XLSX.utils.table_to_book(table, { sheet: "Attendance" });
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

  setTimeout(() => {
    toast.style.display = 'none';
  }, 3000);
}
