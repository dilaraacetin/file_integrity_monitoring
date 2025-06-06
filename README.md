# 🔐 File Integrity Monitoring Script (Bash)

This Bash script monitors file integrity in a specified directory by comparing current file hashes against a baseline. It is designed to be run via **cron** for periodic checks.

---

## 📂 Features

- Uses `sha256sum` to hash all files in `/opt/scripts`
- Creates a baseline on the first run
- Detects:
  - Added files
  - Deleted files
  - Modified files (based on hash comparison)
- Outputs a report to `integrity_report.txt`

---

## 🚀 Usage

1. Place the script in a desired directory (e.g., `/opt/scripts/integrity_check.sh`)
2. Make it executable:
```bash
chmod +x integrity_check.sh
```

3. Run it manually or add to cron:
```bash
crontab -e
```
Add the following line to run it daily at 3:00 AM:
```
0 3 * * * /bin/bash /opt/scripts/integrity_check.sh
```

4. Check `integrity_report.txt` for results after the script runs.

---

## 📁 Output Files

- `baseline_hashes.txt` → Created on first run, contains reference hashes
- `integrity_report.txt` → Lists added, deleted, or modified files
