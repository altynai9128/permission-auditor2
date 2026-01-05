#!/usr/bin/env python3
"""Test fix command generation and application."""

import os
import tempfile
import stat
import sys
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../src'))

from auditor import apply_single_fix, suggest_safe_permissions

def test_single_fix_dry_run():
    """Test that fix commands are generated correctly."""
    
    # Create a test file with 777 permissions
    with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.sh') as f:
        f.write("#!/bin/bash\necho 'test'")
        temp_path = f.name
    
    try:
        os.chmod(temp_path, 0o777)
        
        # Create a mock finding
        finding = {
            'path': temp_path,
            'permissions': '777',
            'permissions_octal': '777',
            'issue': 'FULL_777',
            'severity': 'CRITICAL',
            'is_directory': False,
            'owner': os.getlogin(),
            'group': os.getlogin(),
            'uid': os.getuid(),
            'gid': os.getgid()
        }
        
        # Test dry run
        result = apply_single_fix(finding, dry_run=True, backup=False)
        
        assert result['status'] == 'DRY_RUN', f"Expected DRY_RUN, got {result['status']}"
        assert 'chmod' in result['command'], "Command should contain chmod"
        assert '750' in result['command'] or '755' in result['command'], "Should recommend safe permissions"
        
        print("✅ test_single_fix_dry_run: PASSED")
        return True
        
    finally:
        if os.path.exists(temp_path):
            os.unlink(temp_path)
    
    print("❌ test_single_fix_dry_run: FAILED")
    return False

def test_safe_permission_suggestion():
    """Test that appropriate permissions are suggested."""
    
    test_cases = [
        {
            'path': '/home/user/script.sh',
            'permissions': '777',
            'is_directory': False,
            'expected': '750'  # Executable script
        },
        {
            'path': '/etc/myapp/config.conf',
            'permissions': '666',
            'is_directory': False,
            'expected': '640'  # Config file
        },
        {
            'path': '/var/log/app.log',
            'permissions': '777',
            'is_directory': False,
            'expected': '640'  # Log file
        },
        {
            'path': '/home/user/docs/readme.txt',
            'permissions': '777',
            'is_directory': False,
            'expected': '644'  # Regular file
        },
        {
            'path': '/var/www/html',
            'permissions': '777',
            'is_directory': True,
            'expected': '755'  # Web directory
        }
    ]
    
    all_passed = True
    
    for i, test_case in enumerate(test_cases):
        finding = {
            'path': test_case['path'],
            'permissions': test_case['permissions'],
            'issue': 'FULL_777',
            'severity': 'CRITICAL',
            'is_directory': test_case['is_directory'],
            'owner': 'testuser',
            'group': 'testgroup',
            'uid': 1000,
            'gid': 1000
        }
        
        suggestion = suggest_safe_permissions(finding)
        recommended = suggestion['recommended']
        
        if recommended == test_case['expected']:
            print(f"✅ test_case_{i}: {test_case['path']} -> {recommended} (PASSED)")
        else:
            print(f"❌ test_case_{i}: {test_case['path']} -> {recommended} (expected {test_case['expected']})")
            all_passed = False
    
    return all_passed

if __name__ == "__main__":
    print("Testing fix command functionality...\n")
    
    tests = [
        test_single_fix_dry_run,
        test_safe_permission_suggestion
    ]
    
    passed = 0
    for test in tests:
        if test():
            passed += 1
    
    print(f"\nResults: {passed}/{len(tests)} tests passed")
    sys.exit(0 if passed == len(tests) else 1)
