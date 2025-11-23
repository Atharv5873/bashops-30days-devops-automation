#!/bin/bash


# ================================
# Day 3: Inactive User Cleaner
# ================================

INACTIVE_DAYS=30
LOG_DIR="logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/inactive_users_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"

echo "Inactive User Report - $TIMESTAMP" > "$LOG_FILE"
echo "Users inactive for more than $INACTIVE_DAYS days: " >> "$LOG_FILE"
echo "--------------------------------------------------" >> "$LOG_FILE"

USERS=$(awk -F: '$7 ~ /(bash|sh|zsh|ksh)$/ {print $1}' /etc/passwd)

for user in $USERS; do
	if [ "$user" = "root" ]; then
		continue
	fi

	RAW=$(lastlog -u "$user")
	
	if echo "$RAW" | grep -q "Never logged in"; then
	    echo "$user - Never logged in" >> "$LOG_FILE"
	    continue
	fi
	
	LAST_LOGIN_DATE=$(echo "$RAW" | awk 'NR==2 {print $4, $5, $6, $9}')
	
	if [ -z "$LAST_LOGIN_DATE" ]; then
	    echo "$user - Unable to parse last login" >> "$LOG_FILE"
	    continue
	fi
	
	DAYS_AGO=$(( ( $(date +%s) - $(date -d "$LAST_LOGIN_DATE" +%s) ) / 86400 ))
	
	
   	if [ "$DAYS_AGO" -gt "$INACTIVE_DAYS" ]; then
        echo "$user - Inactive for $DAYS_AGO days" >> "$LOG_FILE"
	fi
done
	
echo "Report saved to: $LOG_FILE"
echo "Inactive user scan completed."
	    
	
