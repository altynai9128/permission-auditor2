#!/usr/bin/env python3
"""Test version display."""

import subprocess
import sys

def test_version_in_output():
    """Test that version appears in output."""
    
    # Test help output
    print("Testing --help output for version...")
    result = subprocess.run(
        [sys.executable, 'src/auditor.py', '--help'],
        capture_output=True,
        text=True
    )
    
    output = result.stdout + result.stderr
    
    # Version should be in epilog or somewhere
    if '1.0.0' in output:
        print("✅ Version 1.0.0 found in help output")
        return True
    else:
        print("❌ Version 1.0.0 NOT found in help output")
        print(f"Output preview: {output[:200]}...")
        return False

def test_banner_version():
    """Test version in banner."""
    print("\nTesting banner for version...")
    result = subprocess.run(
        [sys.executable, 'src/auditor.py', '.'],
        capture_output=True,
        text=True
    )
    
    output = result.stdout
    
    if 'v1.0.0' in output or '1.0.0' in output:
        print("✅ Version found in banner/output")
        return True
    else:
        print("❌ Version NOT found in banner/output")
        return False

if __name__ == "__main__":
    test1 = test_version_in_output()
    test2 = test_banner_version()
    
    if test1 and test2:
        print("\n✅ Version tests PASSED")
        sys.exit(0)
    else:
        print("\n❌ Version tests FAILED")
        sys.exit(1)
