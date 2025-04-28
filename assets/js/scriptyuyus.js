
      // Function to filter users based on search and filters
      function filterUsers() {
        const searchValue = document.getElementById('searchInput').value.toLowerCase();
        const filterRole = document.getElementById('filterRole').value.toLowerCase();
        const filterStatus = document.getElementById('filterStatus').value.toLowerCase();
        
        const rows = document.querySelectorAll('#userTable tbody tr');
    
        rows.forEach(row => {
          const name = row.dataset.name.toLowerCase();
          const username = row.dataset.username.toLowerCase();
          const email = row.dataset.email.toLowerCase();
          const role = row.dataset.role.toLowerCase();
          const status = row.dataset.status.toLowerCase();
    
          const matchesSearch = name.includes(searchValue) || 
                              username.includes(searchValue) || 
                              email.includes(searchValue);
          const matchesRole = role.includes(filterRole);
          const matchesStatus = status.includes(filterStatus);
    
          if (matchesSearch && matchesRole && matchesStatus) {
            row.style.display = '';
          } else {
            row.style.display = 'none';
          }
        });
      }
      
      // Attach event listeners
      document.getElementById('filterButton').addEventListener('click', filterUsers);
      document.getElementById('searchInput').addEventListener('keyup', function(e) {
        if (e.key === 'Enter') {
          filterUsers();
        }
      });
      
      // Function to show delete confirmation
      let userToDelete = null;
      
      function deleteUser(userId) {
        userToDelete = userId;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        deleteModal.show();
      }
      
      document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
        if (userToDelete) {
          // Here you would typically make an AJAX call to delete the user
          console.log('Deleting user with ID:', userToDelete);
          // Remove the row from the table
          const row = document.querySelector(`#userTable tbody tr[data-id="${userToDelete}"]`);
          if (row) {
            row.remove();
          }
          // Close the modal
          const deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
          deleteModal.hide();
          
          // Show success message
          alert('User deleted successfully');
        }
      });
      
      // Function to send email (placeholder)
      function sendEmail(email) {
        alert(`Email would be sent to: ${email}`);
        // In a real application, this would open an email client or trigger an email API
      }
      
      // Function to edit user
      let currentEditingUserId = null;
      
      function editUser(userId) {
        currentEditingUserId = userId;
        
        // In a real app, you would fetch user data from your database/API
        // For this example, we'll use the data from the table row
        const row = document.querySelector(`#userTable tbody tr:nth-child(${userId})`);
        
        if (row) {
          document.getElementById('editName').value = row.dataset.name;
          document.getElementById('editUsername').value = row.dataset.username;
          document.getElementById('editEmail').value = row.dataset.email;
          document.getElementById('editRole').value = row.dataset.role;
          document.getElementById('editStatus').value = row.dataset.status;
          document.getElementById('editPassword').value = '';
          
          const editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
          editModal.show();
        }
      }
      
      // Function to save user changes
      function saveUserChanges() {
        if (currentEditingUserId) {
          // Get form values
          const name = document.getElementById('editName').value;
          const username = document.getElementById('editUsername').value;
          const email = document.getElementById('editEmail').value;
          const role = document.getElementById('editRole').value;
          const status = document.getElementById('editStatus').value;
          const password = document.getElementById('editPassword').value;
          
          // In a real app, you would send this data to your server
          console.log('Saving changes for user:', currentEditingUserId, {
            name, username, email, role, status, password
          });
          
          // Update the table row (in a real app, you'd refresh the data from the server)
          const row = document.querySelector(`#userTable tbody tr:nth-child(${currentEditingUserId})`);
          if (row) {
            row.dataset.name = name;
            row.dataset.username = username;
            row.dataset.email = email;
            row.dataset.role = role;
            row.dataset.status = status;
            
            // Update the displayed values
            row.cells[1].textContent = name;
            row.cells[2].textContent = username;
            row.cells[3].textContent = email;
            
            // Update role badge
            let roleBadgeClass = 'bg-label-secondary';
            let roleText = 'Employee';
            if (role === 'superadmin') {
              roleBadgeClass = 'bg-label-primary';
              roleText = 'Superadmin';
            } else if (role === 'admin') {
              roleBadgeClass = 'bg-label-info';
              roleText = 'Admin (HR)';
            }
            row.cells[4].innerHTML = `<span class="badge ${roleBadgeClass}">${roleText}</span>`;
            
            // Update status badge
            const statusBadgeClass = status === 'active' ? 'bg-label-success' : 'bg-label-danger';
            const statusText = status === 'active' ? 'Active' : 'Non Active';
            row.cells[5].innerHTML = `<span class="badge ${statusBadgeClass}">${statusText}</span>`;
          }
          
          // Close the modal
          const editModal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
          editModal.hide();
          
          // Show success message
          alert('User updated successfully');
        }
      }