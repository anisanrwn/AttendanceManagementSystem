document.addEventListener("DOMContentLoaded", async () => {
    const tbody = document.getElementById("logTableBody");
    if (!tbody) {
      console.error("Element logTableBody tidak ditemukan");
      return;
    }

    try {
      const response = await fetch("http://127.0.0.1:8000/activitylogs/activity/logs", {
        headers: {
          'Content-Type': 'application/json',
          // Tambahkan token jika dibutuhkan:
          // 'Authorization': `Bearer ${token}`
        }
      });

      if (!response.ok) throw new Error("Gagal fetch logs");
      const logs = await response.json();

      tbody.innerHTML = ''; // kosongkan tbody

      if (logs.length === 0) {
        const tr = document.createElement("tr");
        tr.innerHTML = `<td colspan="5" class="text-center">Tidak ada aktivitas ditemukan</td>`;
        tbody.appendChild(tr);
        return;
      }

      logs.forEach(log => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
          <td class="text-center">${log.timestamp || '-'}</td>
          <td class="text-center"><span class="badge bg-label-${log.user_roles_name || 'secondary'}">${log.user_name || '-'}</span></td>
          <td class="text-center">${log.action || '-'}</td>
          <td class="text-center">${log.ip_address || '-'}</td>
          <td class="text-center">${log.device || '-'}</td>
        `;
        tbody.appendChild(tr);
      });

    } catch (error) {
      console.error("Error fetching logs:", error);
      alert("Gagal memuat activity log.");
    }
  });