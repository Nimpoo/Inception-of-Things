#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. You can't modify /etc/hosts otherwise." >&2
    exit 1
fi

IP="192.168.56.110"
APPS="app1.com app2.com app3.com"

echo "Adding the VM address IP who hosts the apps to /etc/hosts..."
if grep -q "^$IP.*app1.com" /etc/hosts && grep -q "^$IP.*app2.com" /etc/hosts && grep -q "^$IP.*app3.com" /etc/hosts; then
    echo "Already exists"
else
    echo "$IP   $APPS" >> /etc/hosts
    echo "Added successfully"
fi
echo "Done."
