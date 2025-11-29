## Day 8 – Advanced Service Health Watchdog (Continuous Monitoring + Auto-Restart + Slack Alerts)

### Description

This script continuously monitors the health of a Linux service and ensures it stays running.  
Unlike the Day 2 script (single-run checker), this version acts as a **real watchdog**:

- Checks the service every few seconds  
- Automatically restarts it if it goes down  
- Sends a real-time Slack alert  
- Logs every event with timestamps  
- Runs indefinitely in the background (ideal for systemd)

This tool is widely used in **DevOps**, **SRE**, and **SysAdmin** environments to prevent downtime, maintain SLAs, and add **self-healing behavior** to critical services such as `nginx`, `apache2`, `mysql`, `redis`, `docker`, `mongodb`, etc.

In this demo, the script was tested successfully in a controlled environment, and Slack alerts were successfully received using the `$SLACK_WEBHOOK_URL` environment variable.

---

### Features

- Continuous service health monitoring (looping watchdog)  
- Auto-restart on service failure  
- Real-time Slack alerts via incoming webhook  
- Timestamped logging for auditing & debugging  
- Works with all systemd-managed services  
- Customizable check interval (default: **10 seconds**)  
- Safe background execution using **nohup** or **systemd**  
- Lightweight and production-friendly  
- Perfect for SRE, DevOps, automation, and system maintenance tasks  

---

### How to Run the Script

```bash
chmod +x advanced_service_watchdog.sh     # Make executable
./advanced_service_watchdog.sh nginx      # Monitor nginx service

```

Run in background (recommended for servers):

```bash
sudo nohup ./advanced_service_watchdog.sh nginx >/dev/null 2>&1 &
```

### Example Output (Inside logs/)
```bash
Advanced Watchdog Started for service: nginx
Interval: 10 seconds
------------------------------------------
Fri Jan 3 12:10:22 UTC 2025: nginx is running.
Fri Jan 3 12:10:32 UTC 2025: [ALERT] nginx is DOWN!
Fri Jan 3 12:10:32 UTC 2025: Attempting restart...
Fri Jan 3 12:10:33 UTC 2025: Restart SUCCESSFUL.
```
A Slack message was also successfully delivered

---

### Use Cases

- Monitoring critical services like **nginx**, **apache2**, **mysql**, **redis**, **docker**, **mongodb**, etc.  
- Preventing unexpected downtime and ensuring service stability  
- Adding **self-healing** to services without requiring full monitoring stacks  
- Lightweight replacement for **Monit** or **Supervisor** on small setups  
- Running on VMs, cloud servers, Kubernetes nodes, edge devices, or CI/CD agents  
- Integrating into **SRE on-call alerting pipelines** via Slack notifications  
- Ensuring **high availability** for essential backend and web services  

