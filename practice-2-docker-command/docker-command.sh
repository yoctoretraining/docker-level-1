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

info "1" ": Lister toutes les commandes du binaire docker"
echo -e "${prt} docker"

info "2" ": Afficher les informations liés à docker"
echo -e "${prt} docker info"

info "3" ": Identifier la commande qui permet de chercher une image sur le registre public docker"
echo -e "${prt} docker search"

info "4" ": Rechercher les images officielles suivantes : Redis, Mongodb, Elasticsearch"
echo -e "${prt} docker redis"
echo -e "${prt} docker mongo"
echo -e "${prt} docker elasticsearch"

info "5" ": Identifier la commande qui permet de récupérer une image sur le registre public docker"
echo -e "${prt} docker pull"

info "6" ": Identifier la commande qui permet d’afficher les images disponibles"
echo -e "${prt} docker images"

info "7" ": Identifier la commande qui permet de construire une image"
echo -e "${prt} docker build"

info "8" ": Identifier la commande qui permet de supprimer une image"
echo -e "${prt} docker rmi"

info "9" ": Identifier la commande qui permet de lister les containers"
echo -e "${prt} docker ps -a"

info "10" ": Identifier la commande qui permet de supprimer un container"
echo -e "${prt} docker rm"

info "11" ": Identifier la commande qui permet l’affichage des logs d’un container"
echo -e "${prt} docker logs"

info "12" ": Identifier la commande qui permet de redémarrer un container"
echo -e "${prt} docker restart"

info "13" ": Identifier la commande qui permet de mettre en pause un container"
echo -e "${prt} docker pause"

info "14" ": Identifier la commande qui permet d’arrêter un container"
echo -e "${prt} docker stop"

info "15" ": Identifier la commande qui permet de lancer un container"
echo -e "${prt} docker start"

