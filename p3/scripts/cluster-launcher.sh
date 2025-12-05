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

k3d cluster create --no-lb --agents 0 p3-cluster
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# ? I - Lancer cette commande pour port forwarding le dashboard Argo CD sur le port 8080 de la machine hôte et y accéder via http://localhost:8080
# * ```
# * sudo kubectl port-forward svc/argocd-server -n argocd 8080:443
# * ```
# ! PORT FORWARDING, BLOQUE LE PROMPT, LANCE LE DASHBOARD ARGO CD SUR LE PORT 8080

# ? II - Récupérer le mot de passe initial pour l'utilisateur admin
# * ```
# * sudo argocd admin initial-password -n argocd
# * ```
# ? Se connecter au dashboard + CLI avec l'utilisateur admin et le mot de passe récupéré

# ? III - Supprimer le `secret` qui stock le mot de passe initial pour des raisons de sécurité
# * ```
# * sudo kubectl delete secret -n argocd argocd-initial-admin-secret
# * ```

# ? IV - Se connecter via Argo CD CLI
# * ```
# * sudo argocd login localhost:8080 --username admin --password <password>
# * ```

# ? V - Changer le mot de passe de l'utilisateur admin
# * ```
# * sudo argocd account update-password
# * ```

# ? VI - Ajouter le cluster k3d au CLI Argo CD
# * ```
# * sudo argocd cluster add k3d-p3-cluster
# * ```
# ! S'il y a un probleme lors de l'ajout du cluster k3d au CLI Argo CD, consulter : https://github.com/Nimpoo/Inception-of-Things/wiki/V-%E2%80%90-ArgoCD,-CI-CD,-GitOps-Model#warning
# ! COMMANDE NON NECESSAIRE, VOIR ICI : https://github.com/Nimpoo/Inception-of-Things/wiki/V-%E2%80%90-ArgoCD,-CI-CD,-GitOps-Model#important-edit
