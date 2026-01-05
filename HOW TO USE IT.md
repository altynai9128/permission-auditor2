# Linux Permission Auditor

## How to Use (Practical Guide)

### Method 1: Direct Python execution
```bash
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
