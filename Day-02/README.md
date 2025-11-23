# Day 2 – Service Watchdog (Auto-Restart Script)

## 📌 Description

This script acts as a lightweight service watchdog. It checks whether a given Linux service is running, and if the service is found stopped, the script will automatically restart it and record the event in a timestamped log file.

This is a common DevOps/SRE use case for maintaining service uptime, reducing downtime, and adding basic self-healing to servers.

---

## 🚀 Features

- Takes a service name as an argument
- Checks the service status using `systemctl`
- Automatically restarts the service if it is down
- Logs every check and restart attempt
- Creates timestamped logs inside the `logs/` directory

---

## How to Run the Script

```bash
chmod +x service_watchdog.sh			# Make the script executable
./service_watchdog.sh <service_name>	# Run it
cat logs/watchdog.*						# View the generated report
```

### Exmples

```bash
./service_watchdog.sh nginx
./service_watchdog.sh apache2
./service_watchdog.sh mysql
```

---

## 🔧 Use Cases

- Keeps important services running
- Prevents unexpected downtime
- Good for small servers without full monitoring systems
- Fits into cron for periodic checks
- Can evolve into a full self-healing agent

