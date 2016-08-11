#####
# Ambientum 1.0
# Debian Jessie as Base Image (Node Packages)
######
FROM debian:jessie

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---Updating Repository---" && \
    apt-get update -y && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get upgrade -y && \
    apt-get install -y curl \
    wget \
    nano \
    vim \
    sudo && \
    echo "---Preparing and Installing Node---" && \
    echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
    curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    apt-get update -y && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    sudo apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Adds a new user that will match most users environments (id 1000)
# Make sure project directory exists and it's owned by the recently
# created user, also, adds that user to the sudoers file
RUN adduser --disabled-password --gecos "" node-user && \
    mkdir -p /var/www/app && \
    chown -R node-user:node-user /var/www && \
    echo "node-user  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

# Configure FPM to run properly on docker
#RUN sed -i "/user = .*/c\user = php-user" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/group = .*/c\group = php-user" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/listen-user = .*/c\listen-user = php-user" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/listen-group = .*/c\listen-group = php-user" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/7.0/fpm/pool.d/www.conf && \
#    sed -i "/pid = .*/c\;pid = /run/php/php7.0-fpm.pid" /etc/php/7.0/fpm/php-fpm.conf && \
#    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php/7.0/fpm/php-fpm.conf && \
#    sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/7.0/fpm/php-fpm.conf && \
#    sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php/7.0/fpm/php.ini && \
#    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php/7.0/fpm/php.ini

# Define the running user
USER node-user

# Application directory
WORKDIR "/var/www/app"

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]
