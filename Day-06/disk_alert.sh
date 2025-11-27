#!/bin/bash

# ================================
# Day 6: Disk Usage Threshold Alert
# ================================

THRESHOLD=80
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/disk_alert_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage Alert Report - $TIMESTAMP" > "$LOG_FILE"
echo "Threshold: $THRESHOLD%" >> "$LOG_FILE"
echo "------------------------------------" >> "$LOG_FILE"

echo "[*] Current usage: $USAGE%" | tee -a "$LOG_FILE"

if [ "$USAGE" -ge "$THRESHOLD" ]; then
	echo "[!] ALERT: Disk usage is above $THRESHOLD%" | tee -a "$LOG_FILE"
	echo "[!] Action required immediately!" | tee -a "$LOG_FILE"

	# Slack Integration
	WEBHOOK_URL="$SLACK_WEBHOOK_URL"
	SLACK_MSG="*Disk Alert on $(hostname)*  
Usage is at *$USAGE%* (Threshold: $THRESHOLD%)  
Server: \`$(hostname -I | awk '{print $1}')\`"

	curl -X POST -H 'Content-type: application/json' \
	--data "{\"text\":\"$SLACK_MSG\"}" "$WEBHOOK_URL" > /dev/null 2>&1

	echo "[!] Slack alert sent." | tee -a "$LOG_FILE"
else
	echo "[+] Disk usage is under control." | tee -a "$LOG_FILE"
fi

echo "[*] Report saved to: $LOG_FILE"
