## Day 7 – Memory Leak Detector (Process Memory Monitoring & Slack Alerts)

### Description

This script scans the system for processes consuming excessive amounts of memory and flags potential memory leaks. It checks all running processes, compares their memory usage against a configurable threshold, and logs high-memory processes into a timestamped report stored under the `logs/` directory.

This tool is extremely valuable in DevOps/SRE environments where runaway processes, misbehaving applications, or memory leaks can slow down or crash production systems.

- In the demo environment, the threshold was intentionally set very low (**0.5%**) for testing.  
- In production, typical values range between **30%–60%** depending on workload and available system RAM.

The script also supports Slack alerting through an **Incoming Webhook**.  
A real Slack message was successfully received during testing via `$SLACK_WEBHOOK_URL`.

---

### Features

- Scans all active processes for memory usage  
- Detects processes exceeding a configurable threshold  
- Logs **PID**, **MEMORY %**, **CPU %**, and **COMMAND**  
- Generates detailed timestamped reports  
- Supports **Slack alerts** (via hidden webhook environment variable)  
- Uses standard Linux tools: `ps`, `awk`, `grep`, `date`  
- Safe for production servers, containers, VMs, and desktops  
- Ideal for **cron-based scheduled monitoring**  
- Helps detect early memory anomalies before escalation  

---

### How to Run the Script
```bash
chmod +x memory_leak_detector.sh        # Make script executable
./memory_leak_detector.sh               # Run with default threshold (30%)
```

To override the threshold temporarily:
```bash
THRESHOLD=50 ./memory_leak_detector.sh
```

Ensure Slack Webhook URL is exported before running (if alerts are enabled):
```bash
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXX/YYY/ZZZ"
```

### Example Output (Inside logs/)
```bash
Memory Leak Detection Report - 2025-11-28_14-43-01
Threshold: 0.5%
---------------------------------------------
[*] Scanning for processes exceeding 0.5% memory...
PID: 3581 | MEM: 1.6% | CPU: 0.4% | CMD: /usr/bin/gnome-shell
PID: 3271 | MEM: 0.8% | CPU: 0.0% | CMD: /usr/lib/xorg/Xorg
PID: 2412 | MEM: 0.7% | CPU: 0.4% | CMD: /usr/bin/mongod
PID: 4017 | MEM: 0.7% | CPU: 0.0% | CMD: /usr/libexec/xdg-desktop-po
PID: 3602 | MEM: 0.6% | CPU: 0.0% | CMD: /usr/libexec/mutter-x11-fra
PID: 3382 | MEM: 0.6% | CPU: 0.0% | CMD: /snap/snapd-desktop-integra

[!] Potential memory leaks found. Review the log file.
```

Slack alert was successfully triggered and received during testing.

---

### **Use Cases**

- Identifying memory leaks in **Java**, **Python**, **Node.js**, **Go**, or other backend services  
- Monitoring memory usage inside **Docker containers** or **Kubernetes pods**  
- Debugging slow servers caused by **high RAM consumption**  
- Running **cron-based periodic leak detection** to catch issues early  
- Sending instant alerts to DevOps/SRE teams via **Slack webhooks**  
- Integrating into **incident-prevention** or **auto-remediation pipelines**  
- Useful across **QA**, **staging**, and **production** environments  

