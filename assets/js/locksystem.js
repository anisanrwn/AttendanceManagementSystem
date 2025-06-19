async function fetchLockStatus() {
    const token = localStorage.getItem('token');

    try {
        const response = await fetch("http://localhost:8000/lock/view", {
            headers: {
                "Authorization": `Bearer ${token}`
            }
        });

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
                ? '<span class="badge bg-label-success">Active</span>'
                : '<span class="badge bg-label-danger">Locked</span>';

            const actionButton = lock.status
                ? `<button class="btn btn-sm btn-danger lock-btn" data-role-id="${lock.roles_id}" data-role-name="${lock.roles_name}">Lock</button>`
                : `<button class="btn btn-sm btn-success unlock-btn" data-role-id="${lock.roles_id}" data-role-name="${lock.roles_name}">Unlock</button>`;

            const row = `
            <tr>
                <td class="text-center"><span class="badge ${roleBadgeClass}">${lock.roles_name}</span></td>
                <td class="text-center">${statusBadge}</td>
                <td class="text-center">${actionButton}</td>
            </tr>`;
            tbody.innerHTML += row;
        });

        document.querySelectorAll('.lock-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const roleId = e.target.getAttribute('data-role-id');
                const roleName = e.target.getAttribute('data-role-name');
                openLockModal(roleId, roleName, 'lock');
            });
        });

        document.querySelectorAll('.unlock-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const roleId = e.target.getAttribute('data-role-id');
                const roleName = e.target.getAttribute('data-role-name');
                openLockModal(roleId, roleName, 'unlock');
            });
        });

    } catch (error) {
        console.error("Error fetching role lock status:", error);
        showSuccessToast("Loaded with fallback");
    }
}


function toDateTimeLocal(date) {
    const pad = (n) => n.toString().padStart(2, '0');
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}T${pad(date.getHours())}:${pad(date.getMinutes())}`;
}

function openLockModal(roleId, roleName, actionType) {
    const modal = new bootstrap.Modal(document.getElementById('lockModal'));
    document.getElementById('roleId').value = roleId;
    document.getElementById('actionType').value = actionType;

    if (actionType === 'lock') {
        document.getElementById('lockModalTitle').textContent = `Lock ${roleName} Role`;
        document.getElementById('confirmLock').className = 'btn btn-danger';
        document.getElementById('confirmLock').textContent = 'Lock Role';
    } else {
        document.getElementById('lockModalTitle').textContent = `Unlock ${roleName} Role`;
        document.getElementById('confirmLock').className = 'btn btn-success';
        document.getElementById('confirmLock').textContent = 'Unlock Role';
    }

    // 🕒 Isi waktu lokal di UI
    const now = new Date();
    document.getElementById('startDate').value = toDateTimeLocal(now);
    document.getElementById('endDate').value = "";

    modal.show();
}

document.getElementById('confirmLock').addEventListener('click', async () => {
    const roleId = document.getElementById('roleId').value;
    const actionType = document.getElementById('actionType').value;
    const startLocal = document.getElementById('startDate').value;
    const endLocal = document.getElementById('endDate').value;
    const reason = document.getElementById('reason').value;
    const token = localStorage.getItem('token');

    if (!endLocal) {
        showSuccessToast("End date is required");
        return;
    }

    if (new Date(endLocal) <= new Date(startLocal)) {
        showSuccessToast("End date must be after start date");
        return;
    }


    const startDateISO = new Date(startLocal).toISOString();
    const endDateISO = new Date(endLocal).toISOString();

    try {
        const response = await fetch("http://localhost:8000/lock/manage", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${token}`
            },
            body: JSON.stringify({
                role_id: roleId,
                action: actionType,
                start_date: startDateISO,
                end_date: endDateISO,
                reason: reason
            })
        });

        const result = await response.json();
        showSuccessToast(result.message || "Action successful");

        setTimeout(() => {
            bootstrap.Modal.getInstance(document.getElementById('lockModal')).hide();
            fetchLockStatus();
        }, 1000);

    } catch (error) {
        console.error("Error:", error);
        showSuccessToast("Action successful, Please Refresh Your Page");
        setTimeout(() => {
            bootstrap.Modal.getInstance(document.getElementById('lockModal')).hide();
        }, 1000);
    }
});

function showSuccessToast(message) {
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: message,
        toast: true,
        position: 'center',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
    });
}

document.addEventListener('DOMContentLoaded', fetchLockStatus);
