require('dotenv').config();
const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');
const http = require('http');

const PGUSER = process.env.PGUSER;
const PGPASSWORD = process.env.PGPASSWORD;
const PGHOST = process.env.PGHOST;
const PGPORT = process.env.PGPORT;
const PGDATABASE = process.env.PGDATABASE;

const backupFolder = path.join(__dirname, 'db_backups');
const remoteBackupFolder = 'gdrive:AttendanceBackup';
const stateFile = path.join(__dirname, '.interval_state.json');

if (!fs.existsSync(backupFolder)) {
  fs.mkdirSync(backupFolder);
}

let isBackingUp = false;
let lastIntervalKey = readLastIntervalKey();
let lastFetchedInterval = null; 
let lastBackupTime = 0; 

// ======================
// Backup Logic
// ======================
function getBackupFileName() {
  const now = new Date();
  return `backup-${now.toISOString().replace(/[:.]/g, '-')}.sql`;
}

function backupDatabase(callback) {
  const backupFilePath = path.join(backupFolder, getBackupFileName());
  const dumpCommand = `pg_dump --host=${PGHOST} --port=${PGPORT} --username=${PGUSER} --format=plain --file="${backupFilePath}" ${PGDATABASE}`;

  console.log('Start backup database to file:', backupFilePath);

  exec(dumpCommand, { env: { ...process.env, PGPASSWORD } }, (error) => {
    if (error) {
      console.error('Error during database backup:', error);
      return callback(error);
    }
    console.log('Database backup completed.');
    callback(null, backupFilePath);
  });
}

function uploadToDrive(filePath, callback) {
  const rcloneCommand = `rclone copy "${filePath}" "${remoteBackupFolder}"`;

  console.log('Uploading to Google Drive...');

  exec(rcloneCommand, (error, stdout) => {
    if (error) {
      console.error('Error uploading to Google Drive:', error);
      return callback(error);
    }
    console.log('Upload successful:', stdout);
    callback(null);
  });
}

function runBackup() {
  if (isBackingUp) return;
  isBackingUp = true;

  backupDatabase((err, backupFilePath) => {
    if (err) {
      isBackingUp = false;
      return;
    }

    uploadToDrive(backupFilePath, (err2) => {
      isBackingUp = false;
      if (err2) return;
      console.log('Backup and upload completed at', new Date().toLocaleString());
    });
  });
}

// ======================
// Interval Logic
// ======================
let currentIntervalMs = null;

function fetchInterval(callback) {
  http.get('http://localhost:8000/api/backup/schedule', (res) => {
    let rawData = '';
    res.on('data', (chunk) => { rawData += chunk; });
    res.on('end', () => {
      try {
        const data = JSON.parse(rawData);
        callback(null, data.interval_minutes);
      } catch (e) {
        callback(e);
      }
    });
  }).on('error', (e) => {
    callback(e);
  });
}


function applyNewInterval(newIntervalMinutes, startTime = "00:00") {
  const roundedInterval = Math.round(newIntervalMinutes);
  if (isNaN(roundedInterval) || roundedInterval < 1) {
    console.warn('Invalid interval, must be >= 1 minute.');
    return;
  }

  if (lastFetchedInterval === roundedInterval) return;

  lastFetchedInterval = roundedInterval;

  const newKey = `interval-${roundedInterval}`;
  lastIntervalKey = newKey;
  saveLastIntervalKey(newKey);

  currentIntervalMs = roundedInterval * 60 * 1000;
  lastBackupTime = Date.now();


}


function monitorIntervalChanges() {
  fetchInterval((err, newIntervalMinutes) => {
    if (err) {
      console.error('Failed to fetch interval:', err.message);
    } else {
      applyNewInterval(newIntervalMinutes);
    }
  });

  const now = Date.now();
  if (
    currentIntervalMs !== null &&
    now - lastBackupTime >= currentIntervalMs &&
    !isBackingUp
  ) {
    runBackup();
    lastBackupTime = now;
  }

  setTimeout(monitorIntervalChanges, 10 * 1000); 
}

// ======================
// State Persistence
// ======================
function saveLastIntervalKey(key) {
  fs.writeFileSync(stateFile, JSON.stringify({ lastIntervalKey: key }), 'utf8');
}

function readLastIntervalKey() {
  try {
    const data = fs.readFileSync(stateFile, 'utf8');
    const json = JSON.parse(data);
    return json.lastIntervalKey || '';
  } catch {
    return '';
  }
}

// ======================
// Start App
// ======================
console.log('Monitoring backup interval');
monitorIntervalChanges();
