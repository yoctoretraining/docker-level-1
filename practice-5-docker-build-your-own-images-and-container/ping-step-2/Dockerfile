# Step Two of practice 5

# From node 4.4.5
FROM node:4.4.5

# Setup maintainer
MAINTAINER FIRSTNAME LASTNAME <mail@domain.ext>

LABEL version="1.0.0"
LABEL description="Mon application ping"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Set environnement vars
ENV APPLICATION_NAME ping
ENV APPLICATION_VERSION 1.0.0
ENV WORKING_DIRECTORY /var/www/${APPLICATION_NAME}
ENV DOCKER_USER infra

# Process add user action
RUN adduser --disabled-password --gecos '' ${DOCKER_USER} && \
adduser ${DOCKER_USER} sudo && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create a working directory
RUN mkdir -p ${WORKING_DIRECTORY}

# Copy entrypoint
COPY extract ${WORKING_DIRECTORY}

# Set correct rights
RUN chown -R ${DOCKER_USER}:${DOCKER_USER} ${WORKING_DIRECTORY}

# Define correct working directory
WORKDIR ${WORKING_DIRECTORY}

# Define correct rights
RUN chmod +x ping.sh

# run npm install
RUN npm install --production

# Define default entry point to start app (out bash script to process specific pm2 scripts on app)
ENTRYPOINT [ "/bin/bash", "ping.sh" ]
