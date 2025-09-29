#!/bin/bash

set -e

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Docker installation
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

# kubectl installation
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
if echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check; then
  echo "kubectl checksum is valid"
else
  echo "kubectl checksum is invalid"
  exit 1
fi

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo rm -rfv kubectl kubectl.sha256

# K3d installation
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# # argocd installation
# curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
# sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
# rm argocd-linux-amd64
