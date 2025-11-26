#!/bin/bash

# ================================
# Day 5: Log Cleaner & Archiver
# ================================

LOG_DIR="/var/log"
ARCHIVE_DIR="archive"
REPORT_DIR="logs"
RETENTION_DAYS=7

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_FILE="$ARCHIVE_DIR/logs_archive_$TIMESTAMP.tar.gz"
REPORT_FILE="$REPORT_DIR/log_cleaner_report_$TIMESTAMP.log"

mkdir -p "$ARCHIVE_DIR" "$REPORT_DIR"

echo "Log Cleanup Report - $TIMESTAMP" > "$REPORT_FILE"
echo "Retention Policy: Delete Logs > $RETENTION_DAYS days" >> "$REPORT_FILE"
echo "---------------------------------------------------------" >> "$REPORT_FILE"

echo "[*] Archiving logs newer than $RETENTION_DAYS days..." | tee -a "$REPORT_FILE"
find "$LOG_DIR" -type f -mtime -"${RETENTION_DAYS}" -print0 | \
    tar --null -czf "$ARCHIVE_FILE" --files-from -
echo "[+] Logs archived at: $ARCHIVE_FILE" | tee -a "$REPORT_FILE"

echo " "


echo "[*] Deleting logs older than $RETENTION_DAYS days..." | tee -a "$REPORT_FILE"
find "$LOG_DIR" -type f -mtime +"${RETENTION_DAYS}" -print -delete >> "$REPORT_FILE"

echo "[+] Cleanup complete. Report saved to $REPORT_FILE"
