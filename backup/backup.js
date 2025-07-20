const { exec } = require('child_process');
const path = require('path');

const PGUSER = 'Project_owner';
const PGPASSWORD = 'npg_G1t8EPcqVNJp';
const PGHOST = 'ep-fragrant-fog-a1vv7riw.ap-southeast-1.aws.neon.tech';
const PGPORT = '5432'; // default port postgresql
const PGDATABASE = 'Project';


const backupFolder = path.join(__dirname, 'db_backups');

const remoteBackupFolder = 'gdrive:AttendanceBackup';


function getBackupFileName() {
  const now = new Date();
  return `backup-${now.toISOString().replace(/[:.]/g, '-')}.sql`;
}

function backupDatabase(callback) {
  const backupFilePath = path.join(backupFolder, getBackupFileName());

  
  const dumpCommand = `pg_dump --host=${PGHOST} --port=${PGPORT} --username=${PGUSER} --format=plain --file="${backupFilePath}" ${PGDATABASE}`;

  console.log('Start backup database to file:', backupFilePath);


  exec(dumpCommand, { env: { ...process.env, PGPASSWORD } }, (error, stdout, stderr) => {
    if (error) {
      console.error('Error backup database:', error);
      return callback(error);
    }
    console.log('Backup database done.');
    callback(null, backupFilePath);
  });
}


function uploadToDrive(filePath, callback) {
  const rcloneCommand = `rclone copy "${filePath}" "${remoteBackupFolder}"`;

  console.log('Upload backup to Google Drive:', remoteBackupFolder);

  exec(rcloneCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('Error upload to Google Drive:', error);
      return callback(error);
    }
    console.log('Upload successfully:', stdout);
    callback(null);
  });
}

function runBackup() {
  backupDatabase((err, backupFilePath) => {
    if (err) return;

    uploadToDrive(backupFilePath, (err2) => {
      if (err2) return;

      console.log('Backup and upload done', new Date().toLocaleString());
    });
  });
}


console.log('Automated backup Start, interval 1 day...');
runBackup();
setInterval(runBackup, 24 * 60 * 60 * 1000);

