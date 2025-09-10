#!/bin/bash

set -e

# Docker installation
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

sudo systemctl enable docker
sudo systemctl start docker

sudo rm -rfv install-docker.sh

# K3d installation
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
