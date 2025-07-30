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
                <button class="btn btn-sm btn-info" onclick="viewAccount(${user.user_id})">View</button>
                <button class="btn btn-sm btn-danger" onclick="deleteAccount(${user.user_id})">Delete</button>
                <button class="btn btn-sm btn-warning" onclick="editAccount(${user.user_id})">Edit</button>
                <button class="btn btn-sm btn-primary" onclick="syncEmail(${user.user_id})">Sync Email</button>
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
        defaultOption.textContent = '(Optional) Assign this account to an employee';
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
async function loadRoles(dropdownIds = ['roleSelect','filterRole']) {
    try {
        const response = await fetch('http://localhost:8000/user/available_roles'); 
        const roles = await response.json();
        dropdownIds.forEach(id => {
            const roleSelect = document.getElementById(id);

            roles.forEach(role => {
                const option = document.createElement('option');
                option.value = role.roles_name;
                option.textContent = role.roles_name;
                roleSelect.appendChild(option);
            });
        });
    } catch (error) {
        console.error('Failed to load roles', error);
    }
}
loadRoles();

async function isEmailAvailable(email, userId = null) {
    try {
        let url = `http://localhost:8000/user/check_email/${email}`;
        if (userId) url += `?exclude_id=${userId}`;
        const response = await fetch(url);
        const result = await response.json();
        return result.available;
    } catch (error) {
        console.error("Error checking email availability:", error);
        return false;
    }
}

async function isUsernameAvailable(username, userId = null) {
    try {
        let url = `http://localhost:8000/user/check_username/${username}`;
        if (userId) url += `?exclude_id=${userId}`;
        const response = await fetch(url);
        const result = await response.json();
        return result.available;
    } catch (error) {
        console.error("Error checking username availability:", error);
        return false;
    }
}

function getAuthHeaders() {
    const token = localStorage.getItem("token");
    if (!token) {
        Swal.fire("Unauthorized!", "Please login first.", "warning");
        throw new Error("Unauthorized");
    }
    return {
        "Authorization": `Bearer ${token}`
    };
}


// add user
document.getElementById('submitAccount').addEventListener('click', saveAccount);
async function saveAccount(e) {
    e.preventDefault(); 

    // manual validate
    const username = document.getElementById('username').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const role = document.getElementById('roleSelect').value.trim();
    const emailAvailable = await isEmailAvailable(email);
    const usernameAvailable = await isUsernameAvailable(username);
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    if (!username || !email || !password || !role) {
        Swal.fire('Error!', 'Please fill in all required fields.', 'error');
        return;
    }
    if (!usernameAvailable) {
        Swal.fire('Error!', 'Username already exists. Please choose another one.', 'error');
        return;
     }
    if (!emailRegex.test(email)) {
        Swal.fire('Error!', 'Please enter a valid email address. Example : yourname@gmail.com', 'error');
        return;
    }
    if (!emailAvailable) {
        Swal.fire('Error!', 'Email already exists. Please choose another one.', 'error');
        return;
    }
    if (password && !passRegex.test(password)) {
        Swal.fire('Error!', 'Password must be at least 8 characters long and include uppercase letters, lowercase letters, numbers, and symbols', 'error');
        return;
    }
    
    //add account
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
          headers: getAuthHeaders(),
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

//edit account
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

    const emailInput = document.getElementById("editEmail");
    if (user.employee) {
        emailInput.readOnly = true;
        emailInput.style.backgroundColor = "#e9ecef";
        emailInput.style.cursor = "pointer";
        emailInput.onclick = () => {
            Swal.fire({
                title: "Cannot Edit Email Here",
                text: "This email is linked to the employee profile. Please edit it from the Employee Profile page then click sync email in user list action.",
                icon: "info",
                confirmButtonText: "OK"
            });
        };
    } else {
        emailInput.readOnly = false;
        emailInput.style.backgroundColor = "";
        emailInput.style.cursor = "text";
        emailInput.onclick = null;
    }

    $('#editAccountModal').modal('show');
}

async function saveUserChanges() {
    const userId = document.getElementById("editUserId").value;
    const eusername = document.getElementById('editUsername').value.trim();
    const eemail = document.getElementById('editEmail').value.trim();
    const erole = document.getElementById('editRole').value.trim();
    const epassword = document.getElementById("editPassword").value.trim();
    const eusernameAvailable = await isUsernameAvailable(eusername, userId);
    const eemailAvailable = await isEmailAvailable(eemail, userId);    
    const eemailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const epassRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])[A-Za-z\d@$!%*?&.]{8,}$/

    if (!eusername || !eemail || !erole) {
        Swal.fire('Error!', 'Please fill in all required fields.', 'error');
        return;
    }

    if (!eusernameAvailable) {
        Swal.fire('Error Editing!', 'Username already exists. Please choose another one.', 'error');
        return;
    }

    if (!eemailRegex.test(eemail)) {
        Swal.fire('Error!', 'Please enter a valid email address. Example: yourname@gmail.com', 'error');
        return;
    }

    if (!eemailAvailable) {
        Swal.fire('Error!', 'Email already exists. Please choose another one.', 'error');
        return;
    }

    if (epassword && !epassRegex.test(epassword)) {
        Swal.fire("Error", "Password must be at least 8 characters long and include uppercase letters, lowercase letters, numbers, and symbols (.@$!%*?&).", "error");
        return;
    }

    const formData = new FormData();
    formData.append("username", eusername);
    formData.append("email", eemail);
    formData.append("role_name", erole);
    if (epassword) {
        formData.append("password", epassword);
    }

    try {
        const response = await fetch(`http://localhost:8000/user/update/${userId}`, {
            method: "PUT",
            headers: getAuthHeaders(),
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
            method: 'DELETE',
            headers: getAuthHeaders(),
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

//sync email
async function syncEmail(id) {
  const confirmResult = await Swal.fire({
    title: 'Sync Email from Employee?',
    text: `This will update the user email based on the linked employee data.`,
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#7f82ff',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, Sync it',
    cancelButtonText: 'Cancel'
  });

  if (confirmResult.isConfirmed) {
    try {
      const response = await fetch(`http://localhost:8000/user/sync-email/${id}`, {
        method: 'PUT'
      });

      if (response.ok) {
        const result = await response.json();
        Swal.fire({
          title: 'Synced!',
          text: result.message || 'Email successfully synced.',
          icon: 'success',
          timer: 1500,
          showConfirmButton: false
        });

        // Refresh data
        fetchUsers();
      } else {
        const errorData = await response.json();
        Swal.fire('Error!', errorData.detail || 'Failed to sync email.', 'error');
      }
    } catch (error) {
      Swal.fire('Error!', `An error occurred: ${error.message}`, 'error');
    }
  }
}

async function viewAccount(id) {
    try {
        const token = localStorage.getItem("token");

        const response = await fetch(`http://localhost:8000/user/view/${id}`, {
            method: "GET",
            headers: { "Authorization": `Bearer ${token}` }
        });

        if (!response.ok) throw new Error("User not found");

        const user = await response.json();

        document.getElementById("modalFirstName").innerText = user.first_name;
        document.getElementById("modalLastName").innerText = user.last_name;
        document.getElementById("modalUsername").innerText = user.username;
        document.getElementById("modalEmail").innerText = user.email;
        document.getElementById("modalRoles").innerText = user.roles.join(", ");

        let activityText = `Created on ${user.created.when} by ${user.created.by}`;

        if (user.last_modified) {
            activityText = `Last modified on ${user.last_modified.when} by ${user.last_modified.by}`;
        }

        document.getElementById("modalActivity").innerText = activityText;

        new bootstrap.Modal(document.getElementById("dataModal")).show();

    } catch (err) {
        Swal.fire("Error", err.message, "error");
    }
}

// Filter search
const searchInput = document.getElementById('searchInput');
const filterRole = document.getElementById('filterRole');

let debounceTimer;
const debounce = (callback, delay) => {
    return (...args) => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => callback(...args), delay);
    };
};

searchInput.addEventListener('input', debounce(filterUser, 300));
filterRole.addEventListener('change', filterUser);

document.getElementById('clearFiltersButton').addEventListener('click', () => {
    document.getElementById('searchInput').value = '';
    document.getElementById('filterRole').value = '';
    filterUser();
});

function filterUser() {
    const searchValue = document.getElementById('searchInput').value.toLowerCase();
    const selectedRole = document.getElementById('filterRole').value.toLowerCase();

    const rows = document.querySelectorAll('#userTable tbody tr');

    rows.forEach(row => {
        const username = row.cells[0].textContent.toLowerCase();
        
        const rolesCell = row.cells[2];
        const firstRole = rolesCell.querySelector('.badge')?.textContent.toLowerCase() || '';

        const matchesSearch = username.includes(searchValue);

        const matchesRole = selectedRole === '' || firstRole === selectedRole;

        if (matchesSearch && matchesRole) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

fetchUsers();
filterUser();
