#!/bin/bash

set -e

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine

curl -fsSL https://get.docker.com -o install-docker.sh

sudo sh install-docker.sh

sudo rm -rfv install-docker.sh
