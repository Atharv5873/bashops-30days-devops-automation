#!/bin/bash

# ================================
# Day 4: Auto Backup Script
# ===============================

SOURCE_DIR=$1
BACKUP_DIR="backups"
LOG_DIR="logs"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
LOG_FILE="$LOG_DIR/backup_report_$TIMESTAMP.log"

mkdir -p "$BACKUP_DIR" "$LOG_DIR"

if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: $0 <directory_to_backup>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
	echo "Error Directory '$SOURCE_DIR' does not exist."
	exit 1
fi

echo "Backup Report - $TIMESTAMP" > "$LOG_FILE"
echo "Source Directory: $SOURCE_DIR" >> "$LOG_FILE"
echo "Backup File: $BACKUP_FILE" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

echo "[*] Creating Backup..."
tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2>> "$LOG_FILE"

if [ $? -eq 0 ];then
	echo "[+] Backup Sucessful." | tee -a "$LOG_FILE"
else
	echo "[-] Backup Failed." | tee -a "$LOG_FILE"
	exit 1
fi

echo "[*] Backup saved to $BACKUP_FILE"
echo "[+] Report saved to $LOG_FILE"
