**Problem:** Users often "fix" permission issues with `chmod -R 777`, creating massive security holes.

**Solution:** A permission auditor that:
- 🔍 Scans for dangerous permissions (777, world-writable)
- 📖 Explains issues in plain English  
- 🛡️ Suggests correct permissions based on use case
- 🔒 Fixes with single command (safely)
- 🐳 Handles Docker/container UID mapping

## Features
✅ **Find 777 & world-writable permissions**  
✅ **Plain English explanations** of security risks  
✅ **Context-aware permission suggestions**  
✅ **Safe operation** (only shows fixes, doesn't apply automatically)  
✅ **Docker support** with UID/GID mapping analysis  
✅ **JSON output** for automation  
✅ **Works in WSL/Linux environments**
## Quick Start
```bash
# Clone repository
git clone https://github.com/YOUR-USERNAME/permission-auditor.git
cd permission-auditor

# Run directly
python3 src/auditor.py --help

# Test with examples
python3 src/auditor.py test-examples --fix
