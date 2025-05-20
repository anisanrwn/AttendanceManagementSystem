export function showAlert(type, message) {
    Swal.fire({
        icon: type,
        title: type === 'error' ? 'Oops...' : 'Notification',
        text: message,
        confirmButtonText: 'OK',
        confirmButtonColor: '#696cff'
    });
}
