###
# Ambientum
#
# Repository:    Node.JS
# Image:         CLI/Base
# Version:       17.x.x
# Strategy:      Based on mhart/alpine-node:17
# Base distro:   Alpine 3.14
#

# Extraction script part (base-build-node-17) was originally created by @mhart at
# https://github.com/mhart/alpine-node

FROM alpine:3.14 as base-build-node-17
ENV VERSION=v17.1.0 NPM_VERSION=8 YARN_VERSION=v1.22.15

RUN apk upgrade --no-cache -U && \
  apk add --no-cache curl gnupg libstdc++

RUN curl -sfSLO https://unofficial-builds.nodejs.org/download/release/${VERSION}/node-${VERSION}-linux-x64-musl.tar.xz && \
  curl -sfSLO https://unofficial-builds.nodejs.org/download/release/${VERSION}/SHASUMS256.txt && \
  grep " node-${VERSION}-linux-x64-musl.tar.xz\$" SHASUMS256.txt | sha256sum -c | grep ': OK$' && \
  tar -xf node-${VERSION}-linux-x64-musl.tar.xz -C /usr --strip 1 && \
  rm node-${VERSION}-linux-x64-musl.tar.xz

RUN npm install -g npm@${NPM_VERSION} && \
  find /usr/lib/node_modules/npm -type d \( -name test -o -name .bin \) | xargs rm -rf

RUN for server in hkps://keys.openpgp.org ipv4.pool.sks-keyservers.net keyserver.pgp.com ha.pool.sks-keyservers.net; do \
    gpg --keyserver $server --recv-keys \
      6A010C5166006599AA17F08146C2130DFD2497F5 && break; \
  done && \
  curl -sfSL -O https://github.com/yarnpkg/yarn/releases/download/${YARN_VERSION}/yarn-${YARN_VERSION}.tar.gz -O https://github.com/yarnpkg/yarn/releases/download/${YARN_VERSION}/yarn-${YARN_VERSION}.tar.gz.asc && \
  gpg --batch --verify yarn-${YARN_VERSION}.tar.gz.asc yarn-${YARN_VERSION}.tar.gz && \
  mkdir /usr/local/share/yarn && \
  tar -xf yarn-${YARN_VERSION}.tar.gz -C /usr/local/share/yarn --strip 1 && \
  ln -s /usr/local/share/yarn/bin/yarn /usr/local/bin/ && \
  ln -s /usr/local/share/yarn/bin/yarnpkg /usr/local/bin/ && \
  rm yarn-${YARN_VERSION}.tar.gz*

RUN apk del curl gnupg && \
  rm -rf /SHASUMS256.txt /tmp/* \
    /usr/share/man/* /usr/share/doc /root/.npm /root/.node-gyp /root/.config \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/docs \
    /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts && \
  { rm -rf /root/.gnupg || true; }


# use previous as base build.
FROM base-build-node-17

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
    wget -O /tini https://github.com/krallin/tini/releases/download/v0.19.0/tini-static && \
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
