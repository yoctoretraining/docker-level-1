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

task () {
  printf "%b\n" "${bldylw}[ Task n° $1 ]${txtrst} $2"
}

prt="${bldgrn}$>${txtrst}"

info "3" ": Reprendre l’exercice 2 en remplaçant « ping » par « pong » : "
task "3.1" "Exposer le port 3000"
echo -e "${prt} EXPOSE 3000 DOCKER_USER infra"

task "3.2" "Lancer l’image avec le nom « pong-v1.0.0 » pour qu’il accepte les les requêtes du port 3000 vers le port 3000 du container, et afficher ses logs"
echo -e "${prt} docker run --name pong-v1.0.0 -p 3000:3000 -d pong:1.0.0"
echo -e "${prt} docker logs -f pong-v1.0.0"

