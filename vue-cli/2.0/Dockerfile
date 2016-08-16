#####
# Ambientum 1.0
# vue-cli builds uses the default node image
######
FROM ambientum/node:6

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Runs as Root for software install
USER root

# Enables GIT
RUN echo "---> Installing GIT for Vue Development" && \
    apt-get update -y && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Switches back to default user
USER node-user

# Install vue-cli 2.0.0
RUN bash -c 'npm install -g vue-cli@2.0.0'
