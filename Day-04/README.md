## Day 4 – Auto Backup Script (Automated Archiving for Linux)

### Description

This script automatically creates a compressed `.tar.gz` backup of any directory you specify.  
It also generates a timestamped backup report inside a dedicated `logs/` folder, helping track backup operations for audit or recovery purposes.

Automated backups are critical for disaster recovery, server maintenance, and data protection — especially when handling configuration files, application data, and important codebases.

This script ensures lightweight, repeatable, and reliable directory-level backups on any Linux system.

---

### Features

- Creates compressed `.tar.gz` backups  
- Stores backups in a structured `backups/` directory  
- Logs every operation with timestamps  
- Validates source directory before execution  
- Uses standard Linux tools (`tar`, `date`)  
- Supports cron job scheduling for automated backups  
- Suitable for DevOps, SRE, and production environments

---

### How to Run the Script

```bash
chmod +x auto_backup.sh                     # Make the script executable
./auto_backup.sh /path/to/directory         # Backup any directory
ls backups/                                 # View backup files
ls logs/                                    # View generated reports
```

## Example Output (Inside logs/)

```bash
Backup Report - 2025-01-01_10-22-15
Source Directory: /var/www/html
Backup File: backups/backup_2025-01-01_10-22-15.tar.gz
----------------------------------------
[+] Backup successful.

```

---

### Use Cases

- Daily or weekly automated backups using cron  
- Backing up application directories or configuration files  
- Preparing for disaster recovery scenarios  
- Archiving code or project directories efficiently  
- Maintaining secure, versioned backups on production systems  
- Integrating directory backups into CI/CD and DevOps pipelines
