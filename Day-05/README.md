## Day 5 – Log Cleaner & Archiver (Automated Log Rotation & Archiving for Linux)

### Description

This script automatically archives recent logs and deletes older logs from the `/var/log` directory based on a configurable retention policy.  
It ensures efficient log management, prevents disk usage spikes, and maintains a clean logging environment ideal for servers, DevOps workflows, and production systems.

Every execution generates a **timestamped report** inside a dedicated `logs/` directory and creates a compressed `.tar.gz` archive inside the `archive/` folder.

This approach helps you maintain lightweight, organized, and compliant log retention practices — especially useful for servers, firewalls, containers, and cloud environments.

---

### Features

- Archives logs **newer** than the retention period  
- Deletes logs **older** than a specified number of days  
- Creates compressed `.tar.gz` archives  
- Generates detailed, timestamped reports for auditing  
- Uses `find`, `tar`, `date`, and other standard Linux utilities  
- Safe handling of filenames using `-print0` and `--null`  
- Works on all major Linux distributions  
- Easily integrable with cron jobs for automation  
- Ideal for DevOps, SRE, sysadmin, and production server maintenance

---

### How to Run the Script
```bash
chmod +x log_cleaner.sh                      # Make script executable
./log_cleaner.sh                              # Run with default settings (7-day retention)

# View archive files
ls archive/

# View cleanup reports
ls logs/
```

## Example Output (Inside logs/)
```bash
Log Cleanup Report - 2025-01-01_09-32-10
Retention Policy: Delete Logs > 7 days
---------------------------------------------------------
[*] Archiving logs newer than 7 days...
[+] Logs archived at: archive/logs_archive_2025-01-01_09-32-10.tar.gz

[*] Deleting logs older than 7 days...
/var/log/app1/app.log.1
/var/log/app2/error.log.3
/var/log/service/access.log.5.gz

[+] Cleanup complete. Report saved to logs/log_cleaner_report_2025-01-01_09-32-10.log

```

---

### Use Cases

- Automated log rotation on Linux servers  
- Keeping `/var/log` clean and storage-efficient  
- Preventing disk exhaustion due to large or unrotated logs  
- Archiving logs required for audits or compliance  
- Cleaning stale logs in NGINX/Apache, Fail2Ban, systemd, UFW, etc.  
- Integrating into cron jobs for daily or weekly scheduling  
- Maintaining production server hygiene with minimal effort  
- DevOps and SRE automation pipelines requiring log cleanup routines  
