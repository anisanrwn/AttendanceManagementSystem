document.addEventListener("DOMContentLoaded", function () {
    document.getElementById('loginForm').addEventListener('submit', async function (event) {
        event.preventDefault();

        const form = event.target;
        const formData = new FormData(form);

        try {
            const response = await fetch("http://127.0.0.1:8000/login/login", {
                method: "POST",
                body: formData,
            });

            if (!response.ok) {
                const errorData = await response.json().catch(() => ({ detail: "Unknown error" }));
                alert(errorData.detail || "Login failed, please try again");
                return;
            }

            const user = await response.json();
            console.log("Login success:", user);

            const roleNames = user.roles.map(role => role.roles_name);

            const userId = user.user_id;
            const employeeId = user.employee_id;

            // Simpan ke sessionStorage
            sessionStorage.setItem("user_id", userId);
            sessionStorage.setItem("employee_id", employeeId);

            if (roleNames.includes("Super Admin") || roleNames.includes("Admin")) {
                window.location.href = `/html/dashboardsuperadmin.html`;
            } else if (roleNames.includes("Employee")) {
                window.location.href = `/html/index.html`;
            } else {
                alert("Role tidak dikenali");
            }
        } catch (error) {
            alert("An error occurred: " + error.message);
        }
    });
});


