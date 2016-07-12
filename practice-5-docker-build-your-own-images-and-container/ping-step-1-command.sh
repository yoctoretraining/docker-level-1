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

info "1" ": Création du ping de l’application ping/pong"
task "1.1" "Créer dans un dossier ping"
echo -e "${prt} mkdir ping"

task "1.2" "Créer dans un dossier ping"
echo -e "${prt} cd ping"
echo -e "${prt} touch Dockerfile"

task "1.3" "Créer dans se dossier un Dockerfile en suivant les directives suivantes : "
task "1.3.1" "Depuis un NodeJS 4.4.5 :"
echo -e "${prt} FROM node:4.4.5"

task "1.3.1" "Avec comme « MAINTAINER » votre Nom et prénom suivi de votre Email avec le format suivant : « NOM Prénom <mail@domain.ext>"
echo -e "${prt} MAINTAINER FIRSTNAME LASTNAME <mail@domain.ext>"

task "1.3.2" "Avec les labels suivants Version => 1.0.0 et Description => Mon application ping"
echo -e "${prt} LABEL version=\"1.0.0\""
echo -e "${prt} LABEL description=\"Mon application ping\""

task "1.3.3" "En mode « noninteractive"
echo -e "${prt} ENV DEBIAN_FRONTEND noninteractive"

task "1.3.4" "Avec les variables d’environnements suivantes : APPLICATION_NAME => ping et APPLICATION_VERSION => 1.0.0"
echo -e "${prt} ENV APPLICATION_NAME ping"
echo -e "${prt} ENV APPLICATION_VERSION 1.0.0"

task "1.3.5" "Créer le fichier « entrypoint.sh » hors du container, qui sera votre point d’entrée d’exécution et qui affiche le message suivant toute les 10 secondes : « Super il s’agit de ma première image personnalisée !!"
echo -e "${prt} touch entrypoint.sh"
echo -e "${prt} while true; do echo '« Super il s’agit de ma première image personnalisée !!'; sleep 10; done"

task "1.3.6" "	Le copier dans le container et lui donner les droits d’exécution"
echo -e "${prt} COPY entrypoint.sh ."
echo -e "${prt} RUN chmod +x entrypoint.sh"

task "1.3.7" "Configurer le point d’entrée du container avec le fichier"
echo -e "${prt} ENTRYPOINT [ \"/bin/bash\", \"entrypoint.sh\" ]"


info "1." "Construire l’image depuis votre Dockerfile avec le tag ping:v1.0.0 et lister la nouvelle image"
echo -e "${prt} docker build -t ping:1.0.0 ."

info "1." "Lancer l’image avec le nom « ping-v1.0.0 » et l’inspecter"
echo -e "${prt} docker run --name ping-v1.0.0 -d ping:1.0.0"
echo -e "${prt} docker inspect ping-v1.0.0"

info "1." "Arrêter et supprimer le container et l’image."
echo -e "${prt} docker stop ping-v1.0.0"
echo -e "${prt} docker rm ping-v1.0.0"
echo -e "${prt} docker rmi ping:1.0.0"

