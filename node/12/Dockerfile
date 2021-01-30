###
# Ambientum
#
# Repository:    Node.JS
# Image:         CLI/Base
# Version:       12.x.x
# Strategy:      Based on mhart/alpine-node:12
# Base distro:   Alpine 3.9
#
FROM mhart/alpine-node:12

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <iamhernandev@gmail.com>"

# Variables for enabling NewRelic
ENV NPM_PACKAGES="/home/ambientum/.cache/npm-packages" \
    NODE_PATH="/home/ambientum/.cache/npm-packages/lib/node_modules" \
    MANPATH="/home/ambientum/.cache/npm-packages/share/man:/usr/share/man" \
    PREFIX='/home/ambientum/.local' \
    PATH="/home/ambientum/.local/bin:/home/ambientum/.cache/npm-packages/bin:/home/ambientum/.yarn/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    TERM=xterm-256color \
    COLORTERM=truecolor

# Add the ENTRYPOINT script
ADD start.sh /scripts/start.sh
ADD bashrc /home/ambientum/.bashrc
ADD bashrc /home/bashrc

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---> Installing base dependencies" && \
    apk add --update \
    wget \
    curl \
    openssh \
    alpine-sdk \
    automake \
    autoconf \
    bash \
    fontconfig \
    libxrender \
    libxext \
    nano \
    vim \
    git \
    unzip \
    wget \
    make \
    sudo && \
    echo "---> Cleaning up" && \
    rm -rf /tmp/* && \
    echo "---> Adding the ambientum user" && \
    adduser -D -u 1000 ambientum && \
    mkdir -p /var/www/app && \
    chown -R ambientum:ambientum /var/www && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "set disable_coredump false" >> /etc/sudo.conf && \
    wget -O /tini https://github.com/krallin/tini/releases/download/v0.18.0/tini-static && \
    chmod +x /tini && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /scripts/start.sh && \
    chmod +x /scripts/start.sh && \
    rm -rf /tmp/*

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Define the custom entry point.
ENTRYPOINT ["/tini", "--", "/scripts/start.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]

# default caching volumes.
VOLUME /home/ambientum
