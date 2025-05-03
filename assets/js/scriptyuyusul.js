const accountForm = document.getElementById("addAccountForm");

// view user table
async function fetchUsers() {
    try {
      const response = await fetch("http://localhost:8000/user/view");
      const users = await response.json();
      const tableBody = document.getElementById("userTable").getElementsByTagName('tbody')[0];
  
      tableBody.innerHTML = '';
      
      users.sort((a, b) => {
        const nameA = (a.employee?.first_name || "").toLowerCase();
        const nameB = (b.employee?.first_name || "").toLowerCase();
        return nameA.localeCompare(nameB);
      });
      
      users.forEach(user => {
        const employee = user.employee || {};
        const row = document.createElement("tr");
        row.innerHTML = `
            <td class="text-center">${employee.first_name || '-'}</td>
            <td class="text-center">${employee.last_name || '-'}</td>
            <td class="text-center">${user.username}</td>
            <td class="text-center">${user.email}</td>
            <td class="text-center">
                ${user.roles.map(role => {
                    const roleBadgeClass = {
                    "Super Admin": "bg-label-primary",
                    "Admin": "bg-label-info",
                    "Employee": "bg-label-warning"
                    }[role.roles_name] || "bg-label-secondary";
                    
                    return `<span class="badge ${roleBadgeClass}">${role.roles_name}</span>`;
                }).join(" ")}
            </td>
            
            <td class="text-center">
                <button class="btn btn-sm btn-warning" onclick="editAccount(${user.user_id})">Edit</button>
                <button class="btn btn-sm btn-danger" onclick="deleteAccount(${user.user_id})">Delete</button>
            </td>
        `;
        tableBody.appendChild(row);
      });
    } catch (error) {
      console.error("Error fetching users:", error);
    }
  }
  fetchUsers();


// load employee list in form add user
async function loadEmployee() {
    try {
        const response = await fetch('http://localhost:8000/user/available_employees'); 
        const employee = await response.json();
        const employeeSelect = document.getElementById('employeeSelect');
        
        employeeSelect.innerHTML = '';

        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.textContent = '-- Select Employee --';
        defaultOption.disabled = true;
        defaultOption.selected = true;
        employeeSelect.appendChild(defaultOption);

        employee.forEach(employee => {
            const option = document.createElement('option');
            option.value = employee.employee_id;
            option.textContent = `${employee.first_name} ${employee.last_name}`;
            option.dataset.email = employee.email;
            employeeSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Failed to load roles', error);
    }
}
loadEmployee();

// auto filled email pas employee selected
document.getElementById('employeeSelect').addEventListener('change', function () {
    const selectedOption = this.options[this.selectedIndex];
    const email = selectedOption.dataset.email || '';
    document.getElementById('email').value = email;
    document.getElementById('email').readOnly = !!email;
});


// load roles yg ada dari database
async function loadRoles() {
    try {
        const response = await fetch('http://localhost:8000/user/available_roles'); // <-- FIXED
        const roles = await response.json();
        const roleSelect = document.getElementById('roleSelect');

        roles.forEach(role => {
            const option = document.createElement('option');
            option.value = role.roles_name;
            option.textContent = role.roles_name;
            roleSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Failed to load roles', error);
    }
}

loadRoles();

// add user
document.getElementById('submitAccount').addEventListener('click', saveAccount);
async function saveAccount(e) {
    e.preventDefault(); 

    const formData = new FormData(accountForm);

    try {
        $('#addAccountModal').modal('hide');

        Swal.fire({
            title: 'Registering...',
            text: 'Please wait while we save the account data.',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        const response = await fetch("http://localhost:8000/user/create", {
            method: "POST",
            body: formData
        });

        Swal.close();

        if (response.ok) {
            Swal.fire({
                title: 'Success!',
                text: 'Account registered successfully!',
                icon: 'success',
                timer: 1500,
                showConfirmButton: false
            });

            accountForm.reset();
            fetchUsers();
            loadEmployee(); 
        
        } else {
            const errorData = await response.json();
            Swal.fire('Error!', errorData.detail || 'Failed to register account.', 'error');
        }

    } catch (error) {
        Swal.fire('Error!', `An error occurred: ${error.message}`, 'error');
    }
}
fetchUsers();

//delete account
async function deleteAccount(id) {
    const confirmResult = await Swal.fire({
        title: 'Are you sure you want to delete?',
        text: `User ID: ${id}`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes',
        cancelButtonText: 'Cancel'
    });

    if (confirmResult.isConfirmed) {
        try {
            const response = await fetch(`http://localhost:8000/user/delete/${id}`, {
            method: 'DELETE'
            });

            if (response.ok) {
                Swal.fire({
                    title: 'Deleted!',
                    text: 'Account successfully deleted.',
                    icon: 'success',
                    timer: 1500,
                    showConfirmButton: false
            });

            fetchUsers();

            } else {
                const errorData = await response.json();
                Swal.fire('Error!', errorData.detail || 'Failed to delete Account.', 'error');
            }
        } catch (error) {
            Swal.fire('Error!', `An error occurred: ${error.message}`, 'error');
        }
    }
}

async function editAccount(userId) {
    const [userResponse, roleResponse] = await Promise.all([
        fetch("http://localhost:8000/user/view"),
        fetch("http://localhost:8000/user/available_roles")
    ]);
    const users = await userResponse.json();
    const roles = await roleResponse.json();
    const user = users.find(u => u.user_id === userId);
    if (!user) return;

    const roleSelect = document.getElementById("editRole");
    roleSelect.innerHTML = "";

    roles.forEach(role => {
        const option = document.createElement("option");
        option.value = role.roles_name;
        option.textContent = role.roles_name;
        roleSelect.appendChild(option);
    });

    document.getElementById("editUsername").value = user.username;
    document.getElementById("editEmail").value = user.email;
    document.getElementById("editRole").value = user.roles[0]?.roles_name || '';
    document.getElementById("editPassword").value = '';
    document.getElementById("editUserId").value = user.user_id;

    $('#editAccountModal').modal('show');
}


async function saveUserChanges() {
    const form = document.getElementById("editAccountForm");
    const userId = document.getElementById("editUserId").value;
    const formData = new FormData();

    formData.append("username", document.getElementById("editUsername").value);
    formData.append("email", document.getElementById("editEmail").value);
    formData.append("role_name", document.getElementById("editRole").value);

    const password = document.getElementById("editPassword").value;
    if (password) {
        formData.append("password", password);
    }

    try {
        const response = await fetch(`http://localhost:8000/user/update/${userId}`, {
            method: "PUT",
            body: formData,
        });

        if (response.ok) {
            Swal.fire("Success", "Account updated successfully!", "success");
            $('#editAccountModal').modal('hide');
            fetchUsers();
        } else {
            const err = await response.json();
            Swal.fire("Error", err.detail || "Failed to update account", "error");
        }
    } catch (error) {
        Swal.fire("Error", error.message, "error");
    }
}