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

echo ""
echo "4. Testing world-writable file..."
echo "test" > /tmp/test-666.txt
chmod 666 /tmp/test-666.txt
python3 src/auditor.py /tmp/test-666.txt --fix | grep -q "HIGH"
if [ $? -eq 0 ]; then
    echo "✅ Found world-writable issue"
else
    echo "❌ Did not find world-writable issue"
fi

echo ""
echo "5. Testing directory scan..."
mkdir -p /tmp/test-dir-777
chmod 777 /tmp/test-dir-777
python3 src/auditor.py /tmp/test-dir-777 --fix | grep -q "CRITICAL"
if [ $? -eq 0 ]; then
    echo "✅ Found directory with 777 permissions"
else
    echo "❌ Did not find directory issue"
fi

# Cleanup
rm -rf /tmp/test-*

echo ""
echo "=== TEST COMPLETE ==="
