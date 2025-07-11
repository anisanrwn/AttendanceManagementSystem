 document.addEventListener('DOMContentLoaded', function() {
          checkCurrentPageAccess();
        });
      
        function checkCurrentPageAccess() {
          const currentPath = window.location.pathname;
          const currentPage = currentPath.substring(currentPath.lastIndexOf('/') + 1);
          
          const restrictedPages = {
            'LockSystem.html': ['Admin'],
            'LogActivity.html': ['Admin'],
            'PermissionList.html': ['Super Admin'],
            'RecapAttendance.html': ['Super Admin']
          };
          
          if (restrictedPages[currentPage]) {
            const restrictedRoles = restrictedPages[currentPage];
          
            const userRoles = getUserRoles();
            
            if (hasRestrictedRole(userRoles, restrictedRoles)) {
              showAccessDeniedPopup();
              setTimeout(function() {
                const okButton = document.querySelector('.access-denied-popup button');
                if (okButton) {
                  okButton.onclick = function() {
                    closePopup();
                    if (document.referrer && document.referrer.indexOf(window.location.host) !== -1) {
                      window.location.href = document.referrer;
                    } else {
                      const dashboardPage = userRoles.includes('Admin') || userRoles.includes('Super Admin') 
                        ? '/html/dashboardsuperadmin.html' 
                        : '/html/index.html';
                      window.location.href = dashboardPage;
                    }
                  };
                }
              }, 100);
            }
          }
        }
        
        function checkAccess(targetPage, restrictedRoles) {
          let userRoles = getUserRoles();
          
          if (hasRestrictedRole(userRoles, restrictedRoles)) {
            showAccessDeniedPopup();
          } else {
            window.location.href = targetPage;
          }
        }
        
        function getUserRoles() {
          let userRoles = [];
          
          try {
            const userData = sessionStorage.getItem("userData");
            if (userData) {
              const user = JSON.parse(userData);
              if (user && user.roles) {
                userRoles = user.roles.map(role => role.roles_name);
                return userRoles;
              }
            }
            
            const isAdmin = sessionStorage.getItem("isAdmin") === "true";
            const isSuperAdmin = sessionStorage.getItem("isSuperAdmin") === "true";
            
            if (isAdmin) userRoles.push("Admin");
            if (isSuperAdmin) userRoles.push("Super Admin");
            
            if (userRoles.length > 0) {
              return userRoles;
            }
            
            if (document.referrer.includes("dashboardsuperadmin.html") || 
                window.location.href.includes("dashboardsuperadmin.html")) {
              userRoles = ["Admin", "Super Admin"];
            } else if (document.referrer.includes("index.html") || 
                      window.location.href.includes("index.html")) {
              userRoles = ["Employee"];
            }
            
          } catch (e) {
            console.error("Error getting user roles:", e);
          }
          
          return userRoles;
        }
        
        function hasRestrictedRole(userRoles, restrictedRoles) {
          if (!userRoles || !restrictedRoles || userRoles.length === 0 || restrictedRoles.length === 0) 
            return false;
          
          return userRoles.some(role => restrictedRoles.includes(role));
        }
        
        function showAccessDeniedPopup() {
          closePopup();
          
          const popup = document.createElement('div');
          popup.className = 'access-denied-popup';
          popup.innerHTML = `
            <div class="popup-content">
              <h4>Access Denied</h4>
              <p>You do not have permission to access this page.</p>
              <button>OK</button>
            </div>
          `;
          
          // CSS untuk popup
          const style = document.createElement('style');
          style.textContent = `
            .access-denied-popup {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background-color: rgba(0, 0, 0, 0.5);
              display: flex;
              justify-content: center;
              align-items: center;
              z-index: 9999;
            }
            .popup-content {
              background-color: white;
              padding: 20px;
              border-radius: 5px;
              text-align: center;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            }
            .popup-content button {
              padding: 8px 16px;
              background-color: #696cff;
              color: white;
              border: none;
              border-radius: 4px;
              cursor: pointer;
              margin-top: 10px;
            }
            .popup-content button:hover {
              background-color: #5f61e6;
            }
          `;
          
          document.head.appendChild(style);
          document.body.appendChild(popup);
          
          const button = popup.querySelector('button');
          if (button) {
            button.onclick = closePopup;
          }
        }
        
        function closePopup() {
          const popup = document.querySelector('.access-denied-popup');
          if (popup) {
            popup.remove();
          }
        }