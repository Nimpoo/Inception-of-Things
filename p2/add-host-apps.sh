#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. You can't modify /etc/hosts otherwise." 
   exit 1
fi

echo "Adding the VM address IP who hosts the apps to /etc/hosts..."
echo "192.168.56.110   app1.com" >> /etc/hosts
echo "192.168.56.110   app2.com" >> /etc/hosts
echo "192.168.56.110   app3.com" >> /etc/hosts
echo "Done."
