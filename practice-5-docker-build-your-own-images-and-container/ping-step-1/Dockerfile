# Step One of practice 5

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

# Copy entrypoint
COPY entrypoint.sh .
# Define correct rights
RUN chmod +x entrypoint.sh

# Define default entry point to start app (out bash script to process specific pm2 scripts on app)
ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
