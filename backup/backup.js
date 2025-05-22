const { exec } = require('child_process');
const path = require('path');

// Konfigurasi database (ambil dari .env atau tulis manual)
const PGUSER = 'Project_owner';
const PGPASSWORD = 'npg_G1t8EPcqVNJp';
const PGHOST = 'ep-fragrant-fog-a1vv7riw.ap-southeast-1.aws.neon.tech';
const PGPORT = '5432'; // default port postgresql
const PGDATABASE = 'Project';

// Lokasi folder penyimpanan backup lokal (buat folder ini di project)
const backupFolder = path.join(__dirname, 'db_backups');

// Folder tujuan di Google Drive (sesuaikan dengan nama folder di rclone remote)
const remoteBackupFolder = 'gdrive:AttendanceBackup';

// Nama file backup dengan timestamp
function getBackupFileName() {
  const now = new Date();
  return `backup-${now.toISOString().replace(/[:.]/g, '-')}.sql`;
}

// Step 1: Dump database PostgreSQL ke file .sql
function backupDatabase(callback) {
  const backupFilePath = path.join(backupFolder, getBackupFileName());

  // Pastikan pg_dump terinstall dan ada di PATH, kalau belum install PostgreSQL client tools
  const dumpCommand = `pg_dump --host=${PGHOST} --port=${PGPORT} --username=${PGUSER} --format=plain --file="${backupFilePath}" ${PGDATABASE}`;

  console.log('Mulai backup database ke file:', backupFilePath);

  // Eksekusi perintah pg_dump, gunakan environment variable password agar tidak diminta input
  exec(dumpCommand, { env: { ...process.env, PGPASSWORD } }, (error, stdout, stderr) => {
    if (error) {
      console.error('Error backup database:', error);
      return callback(error);
    }
    console.log('Backup database selesai.');
    callback(null, backupFilePath);
  });
}

// Step 2: Upload file backup ke Google Drive via rclone
function uploadToDrive(filePath, callback) {
  const rcloneCommand = `rclone copy "${filePath}" "${remoteBackupFolder}"`;

  console.log('Upload backup ke Google Drive:', remoteBackupFolder);

  exec(rcloneCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('Error upload ke Google Drive:', error);
      return callback(error);
    }
    console.log('Upload berhasil:', stdout);
    callback(null);
  });
}

// Main function run backup + upload
function runBackup() {
  backupDatabase((err, backupFilePath) => {
    if (err) return;

    uploadToDrive(backupFilePath, (err2) => {
      if (err2) return;

      console.log('Backup dan upload selesai pada', new Date().toLocaleString());
    });
  });
}

// Jalankan backup tiap 1 hari
console.log('Automated backup dimulai, interval 1 hari...');
runBackup();
setInterval(runBackup, 24 * 60 * 60 * 1000);

