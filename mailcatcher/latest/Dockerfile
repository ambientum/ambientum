FROM debian:jessie

MAINTAINER Diego Hernandes <diego@hernandev.com>

RUN apt-get update -y && \
    apt-get install -q -y \
    libsqlite3-dev \
    ruby \
    ruby-dev \
    build-essential && \
    gem install --no-ri --no-rdoc mailcatcher && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

EXPOSE 1080 1025

ENTRYPOINT ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
