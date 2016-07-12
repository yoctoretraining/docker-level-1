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

info "4" ": Faire communiquer l’applicatif ping et pong via l’instruction link, et via le hostname « pong-local »"
echo -e "${prt} docker run --name ping-v1.0.0 --link pong-v1.0.0:pong-local -d ping:1.0.0"

