#!/bin/bash
# Install script for Permission Auditor

echo "Installing Permission Auditor..."

# Make main script executable
chmod +x src/auditor.py

# Copy to /usr/local/bin
sudo cp src/auditor.py /usr/local/bin/perm-audit
sudo chmod +x /usr/local/bin/perm-audit

echo "Installation complete!"
echo "Use: perm-audit --help"
