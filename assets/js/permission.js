document.addEventListener('DOMContentLoaded', function() {
    const permissionForm = document.getElementById('permissionForm');
    const messageBox = document.getElementById('messageBox');
    
    document.getElementById('request_date').value = new Date().toISOString().split('T')[0];
    document.getElementById('employee_id').value = 1;
    
    permissionForm.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        // Tampilkan loading di messageBox
        messageBox.style.display = 'block';
        messageBox.textContent = 'Mengirim permohonan...';
        messageBox.className = 'mt-3 alert alert-info';
        
        try {
            const formData = {
                employee_id: parseInt(document.getElementById('employee_id').value),
                permission_type: document.getElementById('permission_type').value,
                request_date: document.getElementById('request_date').value,
                start_date: document.getElementById('start_date').value,
                end_date: document.getElementById('end_date').value,
                reason: document.getElementById('reason').value,
                permission_status: "Pending"
            };
            
            if (!formData.start_date || !formData.end_date || !formData.permission_type || !formData.reason) {
                throw new Error('Semua field harus diisi!');
            }
            
            if (new Date(formData.start_date) > new Date(formData.end_date)) {
                throw new Error('Tanggal mulai tidak boleh lebih besar dari tanggal selesai!');
            }
            
            const response = await fetch("http://127.0.0.1:8000/permissions/request", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            });
            
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.detail || 'Gagal mengirim permohonan');
            }
            
            const result = await response.json();
            
            // Tampilkan popup alert berhasil
            alert('Save Successfully!');
            
            // Reset form dan sembunyikan messageBox
            permissionForm.reset();
            messageBox.style.display = 'none';
            
        } catch (error) {
            console.error("Error:", error);
            messageBox.textContent = error.message || 'Terjadi kesalahan saat mengirim permohonan';
            messageBox.className = 'mt-3 alert alert-danger';
        }
    });
});
