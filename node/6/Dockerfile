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
    sudo && \
    echo "---> Enabling DotDeb and Node Repository" && \
    echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
    curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Adds a new user that will match most users environments (id 1000)
# Make sure project directory exists and it's owned by the recently
# created user, also, adds that user to the sudoers file
RUN adduser --disabled-password --gecos "" node-user && \
    mkdir -p /var/www/app && \
    chown -R node-user:node-user /var/www && \
    echo "node-user  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

# Define the running user
USER node-user

# Application directory
WORKDIR "/var/www/app"

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]
