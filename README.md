```markdown
# 🔐 Linux Permission Auditor

**Solution to prevent `chmod -R 777` security holes**

[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## 🎯 The Problem

System administrators and developers often "fix" permission issues with the dangerous `chmod -R 777` command, creating massive security vulnerabilities. This tool helps identify and safely fix such problems.

## ✨ Features

- ✅ **Dangerous permission detection**: Find 777 and world-writable files
- ✅ **Plain English explanations**: Simple language instead of technical jargon
- ✅ **Smart recommendations**: Context-aware permission suggestions
- ✅ **Safe single-command fixes**: Generate safe `chmod` commands
- ✅ **Docker container support**: Scan containers and analyze UID mapping
- ✅ **Interactive mode**: Choose which fixes to apply
- ✅ **Multiple output formats**: Human-readable and JSON
- ✅ **Safety first**: Dry-run mode by default, backups on apply

## 📋 Requirements

- Python 3.6 or higher
- Linux/Unix system
- Optional: Docker (for container scanning)

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/permission-auditor.git
cd permission-auditor

# Run the installer
sudo ./scripts/install.sh

# Or install manually
sudo cp src/auditor.py /usr/local/bin/perm-audit
sudo chmod +x /usr/local/bin/perm-audit
```

### Basic Usage

```bash
# Scan a directory
perm-audit /var/www

# Scan recursively with fix suggestions
perm-audit /home -r --fix

# Interactive mode
perm-audit /etc -i

# Apply fixes (with confirmation)
perm-audit /path --apply --interactive

# Docker container scan
perm-audit --docker

# JSON output for scripting
perm-audit /path --json > report.json
```

### Common Examples

**1. Check your web server:**
```bash
perm-audit /var/www/html -r --fix
```

**2. Find all dangerous files in home directories:**
```bash
perm-audit /home -r
```

**3. Audit system directories safely:**
```bash
sudo perm-audit /etc --fix
```

**4. Check and fix a specific project:**
```bash
perm-audit /opt/myapp -r --apply --interactive
```

## 📖 Usage Guide

### Command Line Options

```
usage: perm-audit [-h] [--version] [-r] [-d] [-f] [-a] [-i] [-j] [-o OUTPUT] [path]

Linux Permission Auditor v1.0.0 - Find and fix dangerous permissions

positional arguments:
  path                  Path to scan (default: current directory)

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -r, --recursive       Scan recursively
  -d, --docker          Scan Docker containers
  -f, --fix             Show fix commands (does not apply automatically)
  -a, --apply           Apply fixes (use with caution!)
  -i, --interactive     Interactive fix selection mode
  -j, --json            Output in JSON format
  -o OUTPUT, --output OUTPUT
                        Save report to file
```

### Understanding the Output

The tool provides three severity levels:

- **🚨 CRITICAL**: Files with 777 permissions (read/write/execute for everyone)
- **⚠️ HIGH**: World-writable files (anyone can modify)
- **🔒 MEDIUM**: Sensitive files readable by everyone

For each issue, you'll get:
- Plain English explanation of the risk
- Recommended safe permissions
- Exact command to fix the issue
- Risk reduction assessment

### Safety Features

1. **Dry-run by default**: The `--fix` flag only shows commands, doesn't execute them
2. **Confirmation required**: `--apply` requires explicit confirmation
3. **Backups created**: When applying fixes, backups are created with `.perm-backup-` prefix
4. **Interactive selection**: Choose which fixes to apply in interactive mode
5. **System file protection**: Special handling for critical system files

## 🐳 Docker Support

The auditor can scan running Docker containers for permission issues:

```bash
# Scan all running containers
perm-audit --docker

# Combined scan: filesystem and Docker
perm-audit /var/lib/docker -r --docker
```

Features:
- Automatic Docker detection
- UID/GID mapping analysis between host and containers
- Container-specific permission recommendations
- Support for user namespace mapping

## 🔧 Advanced Usage

### Configuration File

Create `~/.config/permission-auditor/config.json`:

```json
{
  "permission_auditor": {
    "settings": {
      "default_scan_path": ".",
      "recursive_scan": true,
      "max_depth": 8,
      "exclude_patterns": [
        "**/.git/*",
        "**/node_modules/*",
        "/proc/*",
        "/sys/*"
      ]
    }
  }
}
```

### Integration with CI/CD

```bash
# Check for permission issues in CI pipeline
if perm-audit ./src --json | grep -q '"severity": "CRITICAL"'; then
  echo "Critical permission issues found!"
  exit 1
fi

# Generate JSON report
perm-audit . --json > security-audit.json

# Parse with jq
perm-audit . --json | jq '.findings[] | select(.severity == "CRITICAL")'
```

### Scheduled Audits with Cron

```bash
# Daily audit of critical directories
0 2 * * * /usr/local/bin/perm-audit /var/www -r --json > /var/log/permission-audit-$(date +\%Y\%m\%d).json

# Weekly report email
0 3 * * 1 /usr/local/bin/perm-audit /home -r | mail -s "Weekly Permission Audit" admin@example.com
```

## 🧪 Examples

### Example 1: Finding and Fixing 777 Permissions

```bash
# Create a test file with dangerous permissions
echo '#!/bin/bash' > test.sh
echo 'echo "Dangerous!"' >> test.sh
chmod 777 test.sh

# Scan and find the issue
perm-audit . --fix

# Output shows:
# 🚨 CRITICAL SECURITY RISK: test.sh (777)
# ✅ RECOMMENDED FIX: chmod 750 test.sh

# Apply the fix
perm-audit . --apply
```

### Example 2: Interactive Mode

```bash
$ perm-audit /project -r -i

🛠️  INTERACTIVE FIX MODE
1. /project/script.sh (777)
2. /project/config.conf (666)
3. /project/logs/ (777)

Enter numbers to fix (comma-separated), 'a' for all, or 'q' to quit:
> 1,2

📋 Preview of 2 fixes (dry run):
1. /project/script.sh: chmod 750 /project/script.sh
2. /project/config.conf: chmod 640 /project/config.conf

To apply these fixes, run with --apply flag
```

### Example 3: Docker Container Audit

```bash
$ perm-audit --docker

🐳 DOCKER CONTAINER FINDINGS:
1. 🚨 CRITICAL SECURITY RISK
   Path: /app/startup.sh inside container 'webapp'
   Permissions: 777
   ✅ RECOMMENDED FIX: docker exec webapp chmod 750 /app/startup.sh
```

## 🛡️ Security Best Practices

The tool follows and recommends:

1. **Never use `chmod -R 777`** as a quick fix
2. **Directories**: 755 (drwxr-xr-x)
3. **Regular files**: 644 (-rw-r--r--)
4. **Executable scripts**: 750 (-rwxr-x---)
5. **Configuration files**: 640 (-rw-r-----)
6. **Sensitive files**: 600 (-rw-------)
7. **In Docker**: Always use non-root users when possible

## 🚨 Important Disclaimer

⚠️ **This tool identifies potential security issues and suggests fixes.**

⚠️ **Always review and test fixes in a development environment before applying to production systems.**

⚠️ **The tool creates backups when using `--apply`, but you should have your own backups too.**

## 📊 Sample Reports

### Text Report
```
🔐 LINUX PERMISSION AUDIT REPORT
================================
Generated: 2024-01-05 10:30:45
Tool: Permission Auditor v1.0.0

📊 SCAN SUMMARY:
  Total issues found: 3
  🚨 CRITICAL: 2
  ⚠️ HIGH: 1

🔍 DETAILED FINDINGS:
1. 🚨 CRITICAL SECURITY RISK: /var/www/script.sh (777)
   ✅ FIX: chmod 750 /var/www/script.sh
```

### JSON Report
```json
{
  "metadata": {
    "tool": "Linux Permission Auditor",
    "version": "1.0.0",
    "timestamp": "2024-01-05T10:30:45.123456"
  },
  "summary": {
    "total_issues": 3,
    "critical": 2,
    "high": 1
  },
  "findings": [
    {
      "path": "/var/www/script.sh",
      "permissions": "777",
      "severity": "CRITICAL",
      "fix": "chmod 750 '/var/www/script.sh'"
    }
  ]
}
```

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by real-world security incidents from `chmod -R 777`
- Built for system administrators and security-conscious developers
- Thanks to all contributors and testers

## 🔗 Links

- [Issue Tracker](https://github.com/yourusername/permission-auditor/issues)
- [Changelog](CHANGELOG.md)
- [Security Policy](SECURITY.md)

---

## ⚡ Quick Start (30 seconds)

```bash
# Install
git clone https://github.com/yourusername/permission-auditor.git
cd permission-auditor
sudo cp src/auditor.py /usr/local/bin/perm-audit
sudo chmod +x /usr/local/bin/perm-audit

# Basic scan
perm-audit /var/www

# Find and show fixes
perm-audit /home -r --fix

# Apply fixes safely
perm-audit /path --apply --interactive
```

**Need help?** Run `perm-audit --help` or check the examples above!
```
