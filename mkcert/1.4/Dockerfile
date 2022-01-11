###
# Ambientum
#
# Repository:    ambientum/mkcert
# Version:       v1.4.x
# Strategy:      MKCert binary for Docker
# Base distro:   Alpine 3.10
#

# build binary.
FROM golang:1.14-alpine AS build-mkcert

# disable 111.
ENV GO111MODULE=off

# explicit version (for cache-friendly upgrades).
ENV MKCERT_VERSION='1.4.3'

RUN arch

# build it.
RUN apk add --update git bash && \
    cd /go && \
    go get -u github.com/FiloSottile/mkcert && \
    cd src/github.com/FiloSottile/mkcert* && \
    git checkout tags/"v${MKCERT_VERSION}" -b "tag-v${MKCERT_VERSION}" && \
    go build -o /bin/mkcert && \
    chmod +x /bin/mkcert

# dependency-less image.
FROM alpine:3.10

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <iamhernandev@gmail.com>"

# explicit version (for cache-friendly upgrades).
ENV MKCERT_VERSION='v1.4.3'

# make sure terminal is properly configured.
ENV TERM=xterm-256color \
    COLORTERM=truecolor

# Add the ENTRYPOINT script
ADD start.sh /scripts/start.sh
ADD bashrc /home/ambientum/.bashrc
ADD bashrc /home/bashrc

# copy mkcert binary
COPY --from=build-mkcert /bin/mkcert /bin/mkcert
# make sure it's executable.
RUN chmod +x /bin/mkcert

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---> Enabling alpine repositories" && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/community" >> /etc/apk/repositories && \
    echo "---> Installing utils" && \
    apk add --update bash sudo && \
    echo "---> Configuring ambientum user" && \
    adduser -D -u 1000 ambientum && \
    mkdir -p /var/www/app && \
    chown -R ambientum:ambientum /var/www && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "---> Fixing permissions" && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /scripts && \
    chown -R ambientum:ambientum /home/bashrc && \
    chmod +x /scripts/start.sh && \
    echo "---> Cleaning temporary files" && \
    rm -rf /tmp/*

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Environment variables
ENV PATH=/home/ambientum/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Define the entry point that tries to enable newrelic
ENTRYPOINT ["/scripts/start.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/mkcert"]
