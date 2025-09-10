#!/bin/sh
set -e

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

get_distribution() {
    lsb_dist=""
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
    fi
    echo "$lsb_dist"
}

do_uninstall() {
    echo "# Démarrage du script de désinstallation de Docker"
    user="$(id -un 2>/dev/null || true)"
    sh_c='sh -c'
    if [ "$user" != 'root' ]; then
        if command_exists sudo; then
            sh_c='sudo -E sh -c'
        elif command_exists su; then
            sh_c='su -c'
        else
            cat >&2 <<-'EOF'
Erreur : Ce script nécessite les privilèges root pour fonctionner.
Nous ne trouvons ni "sudo" ni "su" pour obtenir ces privilèges.
EOF
            exit 1
        fi
    fi

    lsb_dist=$(get_distribution)
    lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"

    case "$lsb_dist" in
        ubuntu|debian|raspbian)
            (
                echo "Désinstallation des packages Docker..."
                $sh_c 'apt-get remove -y docker docker-engine docker.io containerd runc'
                $sh_c 'apt-get purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras docker-buildx-plugin docker-model-plugin'
                $sh_c 'apt-get autoremove -y --purge'

                $sh_c 'rm -f /etc/apt/sources.list.d/docker.list'
                $sh_c 'rm -f /etc/apt/keyrings/docker.asc'

                echo "Nettoyage des données Docker résiduelles..."
                $sh_c 'rm -rf /var/lib/docker'
                $sh_c 'rm -rf /var/lib/containerd'
            )
            echo "Docker a été désinstallé avec succès."
            exit 0
            ;;
        centos|fedora|rhel)
            (
                echo "Désinstallation des packages Docker..."
                if command_exists dnf; then
                    $sh_c "dnf remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras docker-buildx-plugin docker-model-plugin"
                    $sh_c "dnf autoremove -y"
                else
                    $sh_c "yum remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras docker-buildx-plugin docker-model-plugin"
                    $sh_c "yum autoremove -y"
                fi

                $sh_c 'rm -f /etc/yum.repos.d/docker-ce.repo'

                echo "Nettoyage des données Docker résiduelles..."
                $sh_c 'rm -rf /var/lib/docker'
                $sh_c 'rm -rf /var/lib/containerd'
            )
            echo "Docker a été désinstallé avec succès."
            exit 0
            ;;
        *)
            echo
            echo "ERROR: Distribution '$lsb_dist' non supportée."
            echo
            exit 1
            ;;
    esac
    exit 1
}

do_uninstall

# K3d uninstallation
sudo rm -v $(which k3d)
