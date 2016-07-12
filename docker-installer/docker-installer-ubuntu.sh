#!/bin/bash

# utility function
bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldblu='\033[1;34m'
bldylw='\033[1;33m'
txtrst='\033[0m'

info () {
  printf "%b\n" "${bldblu}[INFO]${txtrst} $1"
}

pass () {
  printf "%b\n" "${bldgrn}[PASS]${txtrst} $1"
}

warn () {
  printf "%b\n" "${bldred}[WARN]${txtrst} $1"
}

# How run scripts
usage="
${bldblu}***************************************************************************************
*          Please refer help below to install docker                                  *
***************************************************************************************${txtrst}

Command : $(basename "$0") [-hu]

- Available options :
 - REQUIRED :
   ${bldgrn}[ -u ] ${txtrst}: First docker user to add on docker group
"
DOCKER_USER=""

# Read all options
while getopts ':h:u:' option; do
  case $option in
    h) echo -e "$usage"
      exit 1
      ;;
    u) DOCKER_USER=${OPTARG}
      ;;
   \?) warn "Invalid option [ -${OPTARG} ]"
     exit 1
     ;;
    :) warn "Option [ -${OPTARG} ] required one argument"
     exit 1
     ;;
  esac
done


## Redis versiopn check
if [ "$DOCKER_USER" != "" ]; then
  # update sources
  info "Updating apt sources"
  apt-get update
  info "Installating audit tools"
  apt-get install auditd audispd-plugins
  # install ca package
  info "Installing required package"
  apt-get install apt-transport-https ca-certificates
  # adding GPG key
  info "Adding GPG Key before installation"
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  # Add source repositories
  info "Add source for docker on source list"
  echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
  # update sources agin
  info "Updating apt sources"
  apt-get update
  # Purge the old repo if it exists.
  info "Purging the old repo if it exists."
  apt-get purge lxc-docker
  # Verify that APT is pulling from the right repository.
  info "Verifing that APT is pulling from the right repository."
  apt-cache policy docker-engine
  # install the linux-image-extra package
  info "Installating extra kernal package"
  apt-get install linux-image-extra-$(uname -r)
  # installing docker engine
  info "Installing docker engine"
  apt-get install docker-engine

  GROUP_EXISTS=$(getent group docker)

  if [ ! -z $GROUP_EXISTS ]; then
    warn "Group docker already exists not processing user add action"
  else
    # Create docker group
    info "Create docker group"
    groupadd docker
    # Add your user to docker group.
    info "Adding user to docker group."
    usermod -aG docker ubuntu ${DOCKER_USER}
  fi

  # Installating docker-compose
  info "Installing docker-compose ..."
  curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  docker-compose --version

  # Changing configuration rules for daemon to follow docker security recommendations
  echo "# It's here our custom docker configuration." >> /etc/default/docker
  echo "# We dont replace previous configuration to keep this configuration safe without any changes" >> /etc/default/docker
  echo "DOCKER_OPTS=--userns-remap=${USER}:docker" >> /etc/default/docker

  #enable content trust
  info "enable content trust in docker"
  export DOCKER_CONTENT_TRUST=1
  # adding docker on boot
  info "Adding docker on boot"
  systemctl enable docker
  # enable aufs storage drive
  info "Stopping docker daemon"
  service docker stop
  #info "Enable aufs storage driver"
  #docker daemon --storage-driver=aufs &
  pass "Docker installation succeed"
  # process securoty checking
  info "Processing Docker Security benchmark"
  docker --name docker_bench_security run -it --net host --pid host --cap-add audit_control \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/systemd:/usr/lib/systemd \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security
else
  warn "Docker user must be provide"
  echo -e "${usage}"
fi