#!/bin/bash

# ===========================
# Day 1: System Health Report
# ===========================

LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/system_report_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

{
	echo "=================================="
	echo " SYSTEM HEALTH REPORT - $TIMESTAMP"
	echo "=================================="

	printf "\n>> CPU USAGE:"
	top -bn1 | grep "Cpu(s)"

	printf "\n>> MEMORY USAGE:"
	free -h

	printf "\n>> DISK USAGE:"
	df -h

	printf "\n>> TOP 5 PROCESSES (CPU):"
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 

	printf "\n>> TOP 5 PROCESSES (MEMORY):"
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 

	printf "\nReport saved to: $LOG_FILE"
	
} >> "$LOG_FILE"

echo "System Health Report generated: $LOG_FILE"
