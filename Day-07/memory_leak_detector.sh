#!/bin/bash

# ====================================
# Day 7: Memory Leak Detector
# ====================================

THRESHOLD=30
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/memory_leak_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

echo "Memory Leak Detection Report - $TIMESTAMP" > "$LOG_FILE"
echo "Threshold: $THRESHOLD%" >> "$LOG_FILE"
echo "---------------------------------------------" >> "$LOG_FILE"

echo "[*] Scanning for processes exceeding ${THRESHOLD}% memory..." | tee -a "$LOG_FILE"

ps -eo pid,ppid,comm,args,%mem,%cpu --sort=-%mem | awk -v t=$THRESHOLD '
NR>1 && $(NF-1) > t {
    printf("PID: %s | MEM: %s%% | CPU: %s%% | CMD: %s\n", $1, $(NF-1), $NF, $4);
}' >> "$LOG_FILE"


if ! grep -q "PID:" "$LOG_FILE"; then
    echo "[+] No memory leaks detected." | tee -a "$LOG_FILE"
else
    echo "[!] Potential memory leaks found. Review the log file." | tee -a "$LOG_FILE"
    WEBHOOK_URL="$SLACK_WEBHOOK_URL"

    curl -X POST -H 'Content-Type: application/json' \
    --data "{\"text\":\"⚠️ High Memory Usage Detected on $(hostname). Check logs.\"}" "$WEBHOOK_URL"  > /dev/null 2>&1
fi

echo "[*] Report saved at: $LOG_FILE"
