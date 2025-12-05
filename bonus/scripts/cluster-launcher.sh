#!/bin/bash

set -e

###

if ! groups "$USER" | grep -q '\bdocker\b'; then
	echo "User must be in the docker group to run this script." >&2
	exit 1
fi

echo -e "\e[1;34m* docker group access verified.\e[0m"

if ! command -v docker >/dev/null 2>&1; then
	echo "Docker is not installed. Please install Docker and try again." >&2
	exit 1
fi

echo -e "\e[1;34m* docker is installed.\e[0m"

if ! command -v k3d >/dev/null 2>&1; then
	echo "k3d is not installed. Please install k3d and try again." >&2
	exit 1
fi

echo -e "\e[1;34m* k3d is installed.\e[0m"

if ! command -v kubectl >/dev/null 2>&1; then
	echo "kubectl is not installed. Please install kubectl and try again." >&2
	exit 1
fi

echo -e "\e[1;34m* kubectl is installed.\e[0m"

if ! command -v argocd >/dev/null 2>&1; then
	echo "argocd is not installed. Please install argocd and try again." >&2
	exit 1
fi

echo -e "\e[1;34m* argocd is installed.\e[0m"

if ! command -v helm >/dev/null 2>&1; then
	echo "helm is not installed. Please install helm and try again." >&2
	exit 1
fi

echo -e "\e[1;34m* helm is installed.\e[0m"

###

k3d cluster create --no-lb --agents 0 bonus-cluster
kubectl create namespace dev
kubectl create namespace gitlab
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

tput setaf 4
echo "Press ANY KEY to continue and start the GitLab installation..."
tput sgr0
read -n 1 -s -r -p ""
echo ""

echo "Checking GitLab Workhorse image signature with Cosign..."
wget https://charts.gitlab.io/cosign.pub
if ! cosign verify --key cosign.pub registry.gitlab.com/gitlab-org/build/cng/gitlab-workhorse-ee:v16.9.0 | jq -r; then
  echo "Error: GitLab Workhorse image signature verification failed." >&2
  rm -fv cosign.pub
  exit 1
fi
rm -fv cosign.pub

echo "Installing GitLab Runners via Helm Chart..."
sudo helm repo add gitlab https://charts.gitlab.io/ --namespace gitlab
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set certmanager-issuer.email=marwan0620@gmail.com \
  --set global.hosts.domain=bonus.com \
  --set global.hosts.gitlab.name=gitlab.bonus.com \
  --set global.hosts.https=false \
  --set global.ingress.tls.enabled=false \
  --set global.edition=ce \
  --set gitlab-runner.install=false \
  --namespace gitlab

tput setaf 1
tput bold
echo "Press ANY KEY to continue and display the GITLAB INITIAL ROOT PASSWORD..."
tput sgr0
read -n 1 -s -r -p ""
echo ""

sudo kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 --decode ; echo

# ? VI - Accéder à GitLab via l'URL : http://gitlab.bonus.com
# * ```
# * sudo kubectl port-forward -n gitlab svc/gitlab-webservice-default 8081:8181
# * ```
# ! PORT FORWARDING, BLOQUE LE PROMPT, LANCE GITLAB SUR LE PORT 8081

# TODO: COMPRENDRE COMMENT SE CONNECTER AU DASHBOARD DE GITLAB PARCE QUE JE VAIS ME DEFENESTRER
