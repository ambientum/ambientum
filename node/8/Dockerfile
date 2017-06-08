#####
# Ambientum 1.0
# Debian Jessie as Base Image (Node Packages)
######
FROM debian:jessie

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Enable DotDeb, install Node 6.x, some utils and cleanup
RUN echo "---> Updating Repository and Installing Utils" && \
    apt-get update -y && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get upgrade -y && \
    apt-get install -y curl \
    wget \
    nano \
    vim \
    sudo \
    git && \
    echo "---> Enabling DotDeb and Node Repository" && \
    echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
    curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Adds a new user that will match most users environments (id 1000)
# Make sure project directory exists and it's owned by the recently
# created user, also, adds that user to the sudoers file
RUN adduser --disabled-password --gecos "" ambientum && \
    mkdir -p /var/www/app && \
    chown -R ambientum:ambientum /var/www && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

# tini to trap signals and allow cancelling execution of cli commands
ADD https://github.com/krallin/tini/releases/download/v0.14.0/tini /tini
RUN chmod +x /tini

# Define the running user
USER ambientum

# Define some NPM jailed environment variables
ENV NPM_PACKAGES="/home/ambientum/.cache/npm-packages" \
    NODE_PATH="/home/ambientumr/.cache/npm-packages/lib/node_modules" \
    MANPATH="/home/ambientum/.cache/npm-packages/share/man:/usr/share/man" \
    PREFIX='/home/ambientum/.local' \
    PATH="/home/ambientum/.local/bin:/home/ambientum/.cache/npm-packages/bin:/home/ambientum/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# NPM config for setting the prefix as well
RUN mkdir -p $NPM_PACKAGES && \
    npm config set prefix $NPM_PACKAGES && \
    npm config set cache '/home/ambientum/.cache/npm'

# Installing Yarn
RUN echo 'Installing Yarn' && \
    curl -o- -L https://yarnpkg.com/install.sh | bash

# Application directory
WORKDIR "/var/www/app"

# Entrypoint
ENTRYPOINT ["/tini", "--"]

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]
