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

info "1" ": Rechercher l'image « redis », la récupérer et lancer l'image."
echo -e "${prt} docker search redis"
echo -e "${prt} docker run --name test-redis -d redis"

info "2" ": Lister les différentes images, arrêter le container 'test-redis' et supprimer l'image redis"
echo -e "${prt} docker images"
echo -e "${prt} docker stop test-redis"
echo -e "${prt} docker rm test-redis"
echo -e "${prt} docker rmi redis"

info "3" ": Effectuer une recherche d’image (au choix) sur le hub, avec la contrainte d’avoir au minimum 20 étoiles, tout en affichant la description complète de l’image, ayant la contrainte de ne pas être une image officielle."
echo -e "${prt} docker search redis"
echo -e "${prt} docker search --stars=20 --no-trunc --automated redis"
