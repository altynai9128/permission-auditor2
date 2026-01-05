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
