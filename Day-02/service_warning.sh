#!/bin/bash

# ===========================
# Day 2: Service Watchdog
# ===========================

SERVICE_NAME=$1
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/watchdog.$TIMESTAMP.log"

if [ -z "$SERVICE_NAME" ];then 
	echo "Usage: $0 <service_name>"
	exit 1
fi

mkdir -p "$LOG_DIR"

check_service(){
	if systemctl is-active --quiet "$SERVICE_NAME";then
		echo "$(date): $SERVICE_NAME is running." >> "$LOG_FILE"
	else
		echo "$(date): $SERVICE_NAME is NOT running! Restarting..." >> "$LOG_FILE"
		systemctl restart "$SERVICE_NAME"

		if systemctl is-active --quiet "$SERVICE_NAME";then
			echo "$(date): Successfully restarted $SERVICE_NAME." >> "$LOG_FILE"
		else
			echo "$(date): FAILED to restart $SERVICE_NAME." >> "$LOG_FILE"
		fi
	fi
}

check_service

echo "Watchdog check compleated. Log: $LOG_FILE"			
