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
            btn.addEventListener('click', async (e) => {
                const roleId = e.target.getAttribute('data-role-id');
                const roleName = e.target.getAttribute('data-role-name');
                await confirmLockAction(roleId, roleName, 'lock');
            });
        });

        document.querySelectorAll('.unlock-btn').forEach(btn => {
            btn.addEventListener('click', async (e) => {
                const roleId = e.target.getAttribute('data-role-id');
                const roleName = e.target.getAttribute('data-role-name');
                await confirmLockAction(roleId, roleName, 'unlock');
            });
        });


    } catch (error) {
        console.error("Error fetching role lock status:", error);
        showSuccessToast("Loaded with fallback");
    }
}



async function confirmLockAction(roleId, roleName, actionType) {
    const token = localStorage.getItem('token');
    const isLock = actionType === 'lock';
    
    const result = await Swal.fire({
        title: `${isLock ? 'Lock' : 'Unlock'} ${roleName}?`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: isLock ? 'Yes, Lock' : 'Yes, Unlock',
        cancelButtonText: 'Cancel'
    });

    if (!result.isConfirmed) return;

    try {
        const bodyData = {
            role_id: roleId,
            action: actionType
        };

        if (isLock) {
            // Default to today until next 30 days (you can customize this)
            const today = new Date();
            const endDate = new Date();
            endDate.setDate(today.getDate() + 30);

            bodyData.start_date = today.toISOString();
            bodyData.end_date = endDate.toISOString();
            bodyData.reason = "Locked via quick action";
        }

        const response = await fetch("http://localhost:8000/lock/manage", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${token}`
            },
            body: JSON.stringify(bodyData)
        });

        const result = await response.json();
        showSuccessToast(result.message || "Action successful");
        fetchLockStatus();

    } catch (error) {
        console.error("Error:", error);
        showSuccessToast("Something went wrong");
    }
}


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
