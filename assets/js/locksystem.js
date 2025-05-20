async function fetchLockStatus() {
    try {
        const response = await fetch("http://localhost:8000/lock/view");
        const locks = await response.json();

        const tbody = document.querySelector("#lockSystemTable tbody");
        tbody.innerHTML = "";

        locks.forEach(lock => {
            const roleBadgeClass = {
                "Super Admin": "bg-label-primary",
                "Admin": "bg-label-info",
                "Employee": "bg-label-warning"
            }[lock.roles_name] || "bg-label-secondary";

            const statusBadge = lock.status
            ? `<span class="badge bg-label-success">Active</span>`
            : `<span class="badge bg-label-danger">Non Active</span>`;

            const row = `
            <tr>
                <td class="text-center"><span class="badge ${roleBadgeClass}">${lock.roles_name}</span></td>
                <td class="text-center">${statusBadge}</td>
            </tr>
            `;
        tbody.innerHTML += row;
      });
    } catch (error) {
      console.error("Error fetching role lock status:", error);
    }
  }
  fetchLockStatus();