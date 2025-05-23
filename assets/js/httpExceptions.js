const httpExceptions = {
    401: {
        default: "Unauthorized access. Please check your credentials.",
        "Email atau password salah.": "Email atau password salah.",
        "Invalid token type": "Token tidak valid.",
        "Invalid refresh token": "Refresh token tidak valid.",
        "Refresh token expired": "Sesi Anda telah habis. Silakan login ulang.",
    },
    403: {
        default: "Anda tidak memiliki akses.",
        "Your role is currently locked. Please contact an administrator.": "Peran Anda dikunci. Hubungi admin.",
        "IP Anda telah diblokir karena terlalu banyak percobaan login yang gagal.": "IP Anda diblokir karena terlalu banyak gagal login.",
        "Akun dikunci. Silakan coba lagi setelah": "Akun dikunci sementara.",
    },
    404: {
        default: "Data tidak ditemukan.",
    }
}