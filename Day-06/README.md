## Day 6 – Disk Usage Threshold Alert (Real-Time Slack Alerting for Linux Servers)

### Description

This script monitors the disk usage of a Linux server and automatically triggers an alert when usage exceeds a defined threshold.  
It helps detect potential disk exhaustion early, preventing system crashes, failed deployments, logging freezes, or application downtime—common issues faced in DevOps and SRE environments.

The script generates a timestamped alert report stored in a `logs/` directory and sends a real-time Slack notification using an Incoming Webhook. This makes it ideal for production monitoring, CI/CD agent machines, container hosts, cloud environments, and demo/test infrastructures.

In the demo environment (`dev.demo`), the threshold was intentionally set to **30%** for testing, and the Slack alert was successfully received.  
In production servers, a safer threshold like **70–80%** is recommended.

---

### Features

- Checks disk usage on the root filesystem (`/`)
- Configurable usage threshold (default: **80%** — can be adjusted)
- Sends a real-time Slack alert using an Incoming Webhook
- Generates a detailed, timestamped log report
- Uses `df`, `awk`, `sed`, and standard Unix command-line tooling
- Includes hostname and server IP for precise identification
- Fully compatible with cron for automated periodic monitoring
- Works in containers, VMs, cloud instances, and bare-metal servers
- Lightweight and production-ready

---

### How to Run the Script
```bash
chmod +x disk_alert.sh                      # Make script executable
./disk_alert.sh                             # Run disk usage check

# View alert logs
ls logs/
```

If you're using a Slack webhook, export it first:
```bash
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXXX/YYYY/ZZZZ"
```

Then run the script normally

## Example Output (Inside /logs)
```bash
Disk Usage Alert Report - 2025-11-27_22-37-21
Threshold: 30%
------------------------------------
[*] Current usage: 39%
[!] ALERT: Disk usage is above 30%
[!] Action required immediately!
[!] Slack alert sent.
```

## Slack Notification Example Received:
```bash
Disk Alert on dev.demo
Usage is at 34% (Threshold: 30%)
Server: 192.168.10.42
```

---

### Use Cases

- Early-warning system for disk exhaustion  
- Automated server monitoring in DevOps + SRE environments  
- Slack-based real-time alerting for Linux infrastructure  
- Monitoring logs, Docker containers, or CI agents  
- Cloud VM, Kubernetes node, or bare metal server tracking  
- Integrating into cron jobs for hourly/daily checks  
- Foundation for advanced monitoring & auto-remediation pipelines  
- Ensuring smooth deployments and preventing outages  

---

### Production Recommendation

- **Demo environment threshold:** 30% (for testing alerts)  
- **Production threshold:** 70–80% depending on system load and volume size  
- Always hide your Slack webhook using environment variables or `.env` files  
- Rotate webhook immediately if leaked or committed accidentally  

