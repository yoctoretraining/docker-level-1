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

info "2" ": Reprendre le « Dockerfile » et rajouté les directives suivantes : "
task "2.1" "Ajouter un utilisateur infra, sans mot de passe et étant « sudoers »"
echo -e "${prt} ENV DOCKER_USER infra"
echo -e "${prt} RUN adduser --disabled-password --gecos '' \${DOCKER_USER} && adduser \${DOCKER_USER} sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

task "2.2" "Définir une variable d’envrionement qui s’appel « WORKING_DIRECTORY » et lui affecter la valeur suivante : /var/www/ping"
echo -e "${prt} ENV WORKING_DIRECTORY /var/www/\${APPLICATION_NAME}"
echo -e "${prt} RUN mkdir -p \${WORKING_DIRECTORY}"

task "2.3" "Demander au formateur les sources du projet « ping-pong », les extraire dans un dossier « extract » et les copier dans /var/www/ping"
echo -e "${prt} COPY extract \${WORKING_DIRECTORY}"

task "2.4" "Attribué les droits de propriété et de groupe de l’utilisateur créer au dossier /var/www/ping"
echo -e "${prt} RUN chown -R \${DOCKER_USER}:\${DOCKER_USER} \${WORKING_DIRECTORY}"

task "2.5" "Définir le « working directory » à /var/www/ping"
echo -e "${prt} WORKDIR \${WORKING_DIRECTORY}"

task "2.6" "Changer le point d’entrer pour exécuter le fichier « ping.sh » et lui donner les bon droits"
echo -e "${prt} RUN chmod +x ping.sh"
echo -e "${prt} ENTRYPOINT [ \"/bin/bash\", \"ping.sh\" ]"

task "2.7" "Rajouter l’execution de la commande suivante : « npm install --production »"
echo -e "${prt} RUN npm install --production"

task "2.8" "Lancer l’image avec le nom « ping-v1.0.0 » et afficher les logs du container"
echo -e "${prt} docker run --name ping-v1.0.0 -d ping:1.0.0"
echo -e "${prt} docker logs -f ping-v1.0.0"
