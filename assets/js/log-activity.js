document.addEventListener("DOMContentLoaded", () => {
  const tbody = document.getElementById("logTableBody");

  const searchNameInput = document.getElementById("searchName");
  const roleFilter = document.getElementById("filterRole");
  const fromDateInput = document.getElementById("filterFromDate");
  const toDateInput = document.getElementById("filterToDate");
  const clearBtn = document.getElementById("clearFiltersButton");

  let allLogs = [];


  function formatStartOfDay(dateStr) {
    const date = new Date(dateStr);
    date.setHours(0, 0, 0, 0);
    return date;
  }

  
  function formatEndOfDay(dateStr) {
    const date = new Date(dateStr);
    date.setHours(23, 59, 59, 999);
    return date;
  }

  async function fetchLogs(startDate = null, endDate = null) {
    let url = "http://127.0.0.1:8000/activitylogs/activity/logs";
    const params = new URLSearchParams();
    if (startDate) params.append("start_date", startDate);
    if (endDate) params.append("end_date", endDate);
    if (params.toString()) url += "?" + params.toString();

    try {
      const response = await fetch(url);
      if (!response.ok) throw new Error("Gagal fetch logs");

      const logs = await response.json();
      allLogs = logs;
      renderLogs(logs);
    } catch (error) {
      console.error("Error fetching logs:", error);
      alert("Gagal memuat activity log.");
    }
  }

  function renderLogs(logs) {
    tbody.innerHTML = '';
    if (logs.length === 0) {
      tbody.innerHTML = `<tr><td colspan="6" class="text-center">Tidak ada aktivitas ditemukan</td></tr>`;
      return;
    }

    logs.forEach(log => {
      const tr = document.createElement("tr");
      tr.innerHTML = `
        <td class="text-center">${log.timestamp || '-'}</td>
        <td class="text-center">${
          log.user_roles && log.user_roles.length > 0
            ? log.user_roles
                .map(role => {
                  const roleBadgeClass = {
                    "Super Admin": "bg-label-primary",
                    "Admin": "bg-label-info",
                    "Employee": "bg-label-warning"
                  }[role] || "bg-label-secondary";
                  return `<span class="badge ${roleBadgeClass} me-1">${role}</span>`;
                })
                .join(" ")
            : `<span class="badge bg-label-danger">Unknown Role</span>`
        }</td>
        <td class="text-center">${
          log.user_name
            ? `<span class="badge ${
                log.user_roles && log.user_roles.length > 0
                  ? {
                      "Super Admin": "bg-label-primary",
                      "Admin": "bg-label-info",
                      "Employee": "bg-label-warning"
                    }[log.user_roles[0]] || "bg-label-secondary"
                  : "bg-label-secondary"
              }">${log.user_name}</span>`
            : `<span class="badge bg-label-danger">Unknown</span>`
        }</td>
        <td class="text-center">${log.action || '-'}</td>
        <td class="text-center">${log.ip_address || '-'}</td>
        <td class="text-center">${log.device || '-'}</td>
      `;
      tbody.appendChild(tr);
    });
  }

  function applyFilters() {
    let filtered = [...allLogs];

    const name = searchNameInput.value.toLowerCase();
    const role = roleFilter.value;
    const fromDate = fromDateInput.value;
    const toDate = toDateInput.value;

    if (name) {
      filtered = filtered.filter(log =>
        log.user_name?.toLowerCase().includes(name)
      );
    }

    if (role) {
      filtered = filtered.filter(log => log.user_roles?.includes(role));
    }

    if (fromDate) {
      const from = formatStartOfDay(fromDate);
      filtered = filtered.filter(log => new Date(log.timestamp) >= from);
    }

    if (toDate) {
      const to = formatEndOfDay(toDate);
      filtered = filtered.filter(log => new Date(log.timestamp) <= to);
    }

    renderLogs(filtered);
  }


  [searchNameInput, roleFilter, fromDateInput, toDateInput].forEach(input => {
    input.addEventListener("input", applyFilters);
    input.addEventListener("change", applyFilters);
  });

 
  clearBtn.addEventListener("click", () => {
    searchNameInput.value = '';
    roleFilter.value = '';
    fromDateInput.value = '';
    toDateInput.value = '';
    fetchLogs(); 
  });

  fetchLogs();
});
