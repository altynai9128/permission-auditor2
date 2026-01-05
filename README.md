# Linux Permission Auditor

## Solution for Pain Point #9
**Prevent security holes caused by `chmod -R 777`**

## Complete Feature Set

### ✅ Core Security Scanning
- **777 Detection**: Finds files/directories with full permissions
- **World-Writable Detection**: Identifies files writable by any user
- **Sensitive File Protection**: Checks /etc/shadow, /etc/sudoers, etc.

### ✅ Intelligent Recommendations
- **Context-Aware Suggestions**: Different fixes for scripts, configs, data files
- **Risk Explanations**: Plain English descriptions of security risks
- **Safe Commands**: Shows `chmod` commands (doesn't execute automatically)

### ✅ Docker & Container Support
- **Container Scanning**: Checks running Docker containers
- **UID/GID Mapping Analysis**: Detects permission mismatches
- **Dockerfile Best Practices**: Suggests secure configurations

### ✅ Enterprise Features
- **JSON Output**: Machine-readable reports for CI/CD
- **Configuration Files**: Customizable scanning rules
- **Comprehensive Logging**: Audit trail for compliance

## 🚀 Quick Start

### Installation
```bash
# Method 1: Direct use
git clone https://github.com/altynai9128/permission-auditor2.git
cd permission-auditor2
python3 src/auditor.py --help

# Method 2: System installation
sudo bash scripts/install.sh
perm-audit --help
