#!/bin/bash
echo "=== QUICK TEST ==="
echo ""

# Test 1: Help
echo "1. Testing help..."
python3 src/auditor.py --help > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Help works"
else
    echo "❌ Help failed"
fi

# Test 2: Basic scan
echo ""
echo "2. Testing basic scan..."
python3 src/auditor.py . > /dev/null 2>&1
if [ $? -eq 0 ] || [ $? -eq 1 ]; then
    echo "✅ Basic scan works"
else
    echo "❌ Basic scan failed"
fi

# Test 3: Create test file and scan
echo ""
echo "3. Creating test file..."
echo "test-content" > /tmp/test-perm-audit.txt
chmod 777 /tmp/test-perm-audit.txt

echo "Scanning test file..."
output=$(python3 src/auditor.py /tmp/test-perm-audit.txt --fix 2>&1)
echo "Output was: $output"
if echo "$output" | grep -q "CRITICAL"; then
    echo "✅ Found 777 permission issue"
else
    echo "❌ Did not find issue"
fi

# Cleanup
rm -f /tmp/test-perm-audit.txt

echo ""
echo "=== TEST COMPLETE ==="
