async function loadLoggedInProfile() {
    try {
      const response = await fetch("http://localhost:8000/employee/me"); // endpoint ini perlu tersedia
      if (!response.ok) throw new Error("Failed to load profile");
  
      const employee = await response.json();
  
      document.getElementById("profileName").innerText = `${employee.first_name} ${employee.last_name}`;
      document.getElementById("profilePosition").innerText = employee.position;
      document.getElementById("profileStatus").innerText = "Active"; // Atau ganti jika backend punya status
      
      document.getElementById("firstName").innerText = employee.first_name;
      document.getElementById("lastName").innerText = employee.last_name;
      document.getElementById("email").innerText = employee.email;
      document.getElementById("organization").innerText = employee.organization || "-";
      document.getElementById("phone").innerText = employee.phone_number;
      document.getElementById("position").innerText = employee.position;
      document.getElementById("department").innerText = employee.department;
      document.getElementById("nrp").innerText = employee.nrp_id;
  
    } catch (error) {
      console.error("Error loading logged-in profile:", error);
      Swal.fire("Error", "Gagal memuat data profil login", "error");
    }
  }
  
  loadLoggedInProfile(); // panggil saat halaman dimuat
  