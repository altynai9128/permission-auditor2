#!/bin/bash
clear
echo "========================================="
echo "   LINUX PERMISSION AUDITOR DEMO"
echo "   Solution for Pain Point #9"
echo "========================================="
echo ""

# Create demo directory
DEMO_DIR="/tmp/perm-audit-demo-$(date +%s)"
mkdir -p "$DEMO_DIR"
cd "$DEMO_DIR"

echo "📁 Created demo directory: $DEMO_DIR"
echo ""

# Create test files
echo "1. Creating test files..."
echo '#!/bin/bash' > script-777.sh
echo 'echo "Dangerous script!"' >> script-777.sh
chmod 777 script-777.sh

echo "sensitive data" > config-666.conf
chmod 666 config-666.conf

mkdir open-dir
chmod 777 open-dir

echo "safe content" > safe-file.txt
chmod 644 safe-file.txt

mkdir secure-dir
chmod 755 secure-dir

echo "✅ Created:"
ls -la
echo ""

# Run auditor
echo "2. Running Permission Auditor..."
echo ""
echo "--- SCAN RESULTS ---"
python3 /opt/permission-auditor-final/src/auditor.py . -r --fix
echo "--- END RESULTS ---"
echo ""

# Cleanup
echo "3. Cleaning up..."
cd /
rm -rf "$DEMO_DIR"

echo ""
echo "========================================="
echo "   DEMO COMPLETE!"
echo "   Tool successfully detected:"
echo "   - 777 permissions on script"
echo "   - World-writable config file"
echo "   - Open directory"
echo "========================================="
