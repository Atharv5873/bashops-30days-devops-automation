# Day 1 – System Health Report Automation

## 📌 Description
This script automatically generates a comprehensive **system health report** and saves it into a **timestamped log file** inside the `logs/` directory.  
It collects essential performance data such as CPU usage, memory usage, disk usage, and the top resource-consuming processes.

This is a foundational **DevOps automation task** commonly used in monitoring, performance diagnosis, and server health audits.

---

## 📂 What the Script Does

The script reports:

- 🖥 **CPU usage** using `top`
- 💾 **Memory usage** using `free -h`
- 🗄 **Disk usage** using `df -h`
- 🔥 **Top 5 CPU-consuming processes**
- 🧠 **Top 5 memory-consuming processes**
- 🕒 Saves evrything into `logs/system_report_<timestamo>.log`

---

## How to Run the Script

```bash
chmod +x system_health.sh	# Make the script executable
./system_health.sh			# Run it
cat log/system_report_*		# View the generated report
```
