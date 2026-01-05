# Test Examples

This directory contains test files for Permission Auditor demonstration.

## Files:
- `dangerous-script.sh` - File with 777 permissions (CRITICAL risk)
- `world-writable.txt` - World-writable file (HIGH risk)
- `secure-file.txt` - File with correct permissions (safe)

## Usage:
```bash
# Test the auditor
python3 src/auditor.py test-examples/ --fix
