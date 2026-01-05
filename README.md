```markdown
# 🔐 Linux Permission Auditor

**Solution to prevent `chmod -R 777` security holes**

## 🎯 The Problem

System administrators and developers often "fix" permission issues with the dangerous `chmod -R 777` command, creating massive security vulnerabilities. This tool helps identify and safely fix such problems.

## ✨ Features

- ✅ **Dangerous permission detection**: Find 777 and world-writable files
- ✅ **Smart recommendations**: Context-aware permission suggestions
- ✅ **Safe single-command fixes**: Generate safe `chmod` commands
- ✅ **Docker container support**: Scan containers and analyze UID mapping
- ✅ **Interactive mode**: Choose which fixes to apply
- ✅ **Multiple output formats**: Human-readable and JSON
- ✅ **Safety first**: Dry-run mode by default, backups on apply

## 📋 Requirements

- Linux/Unix system
- Optional: Docker (for container scanning)

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/permission-auditor2.git
cd permission-auditor2

# Run the installer
sudo ./scripts/install.sh

# Or install manually
sudo cp src/auditor.py /usr/local/bin/perm-audit
sudo chmod +x /usr/local/bin/perm-audit
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
- Explanation of the risk
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

## ⚡ Quick Start (30 seconds)

```bash
# Install
git clone https://github.com/yourusername/permission-auditor2.git
cd permission-auditor2
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
