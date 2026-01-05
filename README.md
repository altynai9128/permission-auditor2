# Linux Permission Auditor

## Solution for Pain Point #9
Prevents security holes caused by `chmod -R 777`.

## Features
- ✅ **Scanning:** Finds 777 and world-writable permissions
- ✅ **Recommendation:** Context-aware permission suggestions
- ✅ **Safety:** Shows fix commands (does NOT apply automatically)
- ✅ **Docker Support:** Container scanning and UID mapping analysis
- ✅ **Multiple Formats:** Human-readable and JSON output

## Installation
# Clone repository
git clone <repository-url>
cd permission-auditor

# Install system-wide
sudo bash scripts/install.sh

# Navigate to project folder
cd /opt/permission-auditor-final

# Basic scan of current directory
python3 src/auditor.py .

# Scan specific directory
python3 src/auditor.py /path/to/scan

# Recursive scan with fix suggestions
python3 src/auditor.py /path -r --fix

# JSON output
python3 src/auditor.py /path --json

# Help
python3 src/auditor.py --help
