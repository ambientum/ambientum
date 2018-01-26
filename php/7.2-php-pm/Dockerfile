###
# Ambientum
#
# Repository:    PHP
# Image:         PHP-FPM + PHP-PM
# Version:       7.2.x
# Strategy:      PHP From PHP-Alpine Repository (CODECASTS) + Official Nginx
# Base distro:   Alpine 3.7
#


## DOWNLOADER SECTION.
FROM ambientum/php:7.2 as downloader

# Download PHP-PM using composer.
RUN mkdir -p /home/ambientum/ppm && \
    cd /home/ambientum/ppm && \
    composer require php-pm/php-pm && \
    composer require php-pm/httpkernel-adapter

###
# Ambientum
#
# Repository:    PHP
# Image:         PHP-FPM + Nginx
# Version:       7.2.x
# Strategy:      PHP From PHP-Alpine Repository (CODECASTS) + Official Nginx
# Base distro:   Alpine 3.7
#
# Inspired by official PHP images.
#
FROM ambientum/php:7.2

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# add start script.
ADD start.sh  /home/ambientum/start.sh

# install related packages (already enabled on base image)
RUN echo "--> Installing PHP-CGI for PHP-PM" && \
    sudo apk add --update php7-cgi@php && \
    sudo rm -rf /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    sudo chmod +x /home/ambientum/start.sh && \
    sudo chown -R ambientum:ambientum /home/ambientum

# copy ppm files from previous state
COPY --from=downloader /home/ambientum/ppm /home/ambientum/ppm

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and nginx on foreground
CMD ["/home/ambientum/start.sh"]
