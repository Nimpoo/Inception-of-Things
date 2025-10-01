#!/bin/bash

set -e

###

if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root." >&2
	exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
	echo "Docker is not installed. Please install Docker and try again." >&2
	exit 1
fi

if ! command -v k3d >/dev/null 2>&1; then
	echo "k3d is not installed. Please install k3d and try again." >&2
	exit 1
fi

if ! command -v kubectl >/dev/null 2>&1; then
	echo "kubectl is not installed. Please install kubectl and try again." >&2
	exit 1
fi

if ! command -v argocd >/dev/null 2>&1; then
	echo "argocd is not installed. Please install argocd and try again." >&2
	exit 1
fi

###

sudo k3d cluster create --no-lb --agents 0 p3-cluster
sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 # ! PORT FORWARDING, BLOQUE LE PROMPT, LANCE LE DASHBOARD ARGO CD SUR LE PORT 8080

# // TODO: SETUP LE CLUSTER AVEC K3D, CREATION DU NAMESPACE "argocd", INSTALLATION DE ARGO CD DANS LE CLUSTER ET CONTINUER A VOIR CE QU'IL RESTE A FAIRE
# TODO: A PARTIR DE CETTE DERNIERE LIGNE DE COMMANDE, CONTINUER LA DOC D'ARGOCD A PARTIR DE LA: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli
