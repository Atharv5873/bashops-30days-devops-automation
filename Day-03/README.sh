## Day 3 – Inactive User Cleaner (Linux Security Automation)

### 📌 Description
This script scans the system for inactive user accounts, identifies users who have not logged in for more than **30 days**, and logs them into a timestamped report.  
It also detects accounts that have **never logged in**, which often indicates unused or forgotten system accounts.

Inactive or stale accounts pose a **security risk**, especially on shared or production servers.  
This script helps automate user-account hygiene and improves the overall **security posture** of a Linux server.

---

### 🚀 Features

- Detects users inactive for **30+ days**  
- Identifies users who **never logged in**  
- Skips the **root** user for safety  
- Parses login information using `lastlog`  
- Saves reports inside the `logs/` directory with timestamps  
- Processes only valid **login shells** (bash, sh, zsh, ksh)  
- Useful for **compliance**, **audits**, and **server-hardening** workflows  

---

### 🧪 How to Run the Script

```bash
chmod +x inactive_user_cleaner.sh     # Make the script executable
sudo ./inactive_user_cleaner.sh       # Run the script (sudo recommended)
cat logs/inactive_users_*             # View the generated report
```

## Example Output (Inside logs/)
```bash
Inactive User Report - 2025-01-01_10-22-15
Users inactive for more than 30 days:
--------------------------------------------------
test - Inactive for 42 days
dev - Never logged in
testerr - Inactive for 190 days
```

### Use Cases

- Detecting stale Linux accounts  
- Improving server security and hygiene  
- Preventing unauthorized access through unused accounts  
- Automating audit and compliance checks  
- Running daily or weekly via cron  
- Useful in enterprise and DevOps environments  
