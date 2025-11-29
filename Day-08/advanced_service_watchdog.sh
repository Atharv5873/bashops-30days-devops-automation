#!/bin/bash

# ==========================================
# Day 8: Advanced Service Health Watchdog
# ==========================================

SERVICE_NAME=$1
INTERVAL=10
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/watchdog_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

if [ -z "$SERVICE_NAME" ]; then
	echo "Usage: $0 <service-name>"
	exit 1
fi 

echo "Advanced Watchdog Started for service: $SERVICE_NAME" | tee -a "$LOG_FILE"
echo "Interval: $INTERVAL seconds" | tee -a "$LOG_FILE"
echo "Logs saved at: $LOG_FILE"
echo "------------------------------------------" >> "$LOG_FILE"

while true; do
	if systemctl is-active --quiet "$SERVICE_NAME"; then
		echo "$(date): $SERVICE_NAME is running." >> "$LOG_FILE"
	else
		
		echo "$(date): [ALERT] $SERVICE_NAME is DOWN!" | tee -a "$LOG_FILE"
		echo "Attempting restart..." | tee -a "$LOG_FILE"
		systemctl restart "$SERVICE_NAME"

		if systemctl is-active --quiet "$SERVICE_NAME"; then
            echo "$(date): Restart SUCCESSFUL." | tee -a "$LOG_FILE"
        else
            echo "$(date): Restart FAILED." | tee -a "$LOG_FILE"
        fi

       	if [ ! -z "$SLACK_WEBHOOK_URL" ]; then
       		 MSG="⚠️ SERVICE ALERT on $(hostname):
Service *$SERVICE_NAME* was DOWN and attempted restart.  
Check logs at: $LOG_FILE"

			curl -X POST -H 'Content-Type: application/json' \
		 	--data "{\"text\":\"$MSG\"}" "$SLACK_WEBHOOK_URL" >/dev/null 2>&1
		fi
	fi

	sleep "$INTERVAL"
done		
		        	
