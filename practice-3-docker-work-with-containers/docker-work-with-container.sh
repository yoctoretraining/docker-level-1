#!/bin/bash

# utility function
bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldblu='\033[1;34m'
bldylw='\033[1;33m'
txtrst='\033[0m'

info () {
  printf "%b\n" "${bldblu}[ Exercice n° $1 ]${txtrst} $2"
}

prt="${bldgrn}$>${txtrst}"

info "1" ": Lancer une image qui affiche « Super ! Mon premier container » dans le terminal"
echo -e "${prt} docker run ubuntu /bin/echo 'Super ! Mon premier container » dans le terminal'"

info "2" ": Lancer une image en mode « daemon » qui affiche toutes les 10 secondes « Super ! Mon premier container autonome qui s’affiche toutes les 10 secondes »"
echo -e "${prt} docker run -d ubuntu /bin/sh -c \"while true; do echo 'Super ! Mon premier container autonome qui s’affiche toutes les 10 secondes'; sleep 10; done\""

info "3" ": Afficher les logs du dernier container lancé"
echo -e "${prt} docker logs -f <ID> or <NAME>"

info "4" ": Arrêter le dernier container lancé et supprimer les différents containers"
echo -e "${prt} docker stop <ID> or <NAME>"
echo -e "${prt} docker rm <ID> or <NAME>"