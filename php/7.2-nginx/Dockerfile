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
LABEL maintainer="Diego Hernandes <diego@hernandev.com>"

# Reset user to root to allow software install
USER root

# Copy nginx and entry script
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl.conf /etc/nginx/ssl.conf
COPY sites /etc/nginx/sites
COPY start.sh  /home/ambientum/start.sh

# Install nginx from dotdeb (already enabled on base image)
RUN echo "--> Installing Nginx" && \
    apk add --update nginx openssl && \
    rm -rf /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    mkdir /var/tmp/nginx && \
    mkdir /var/run/nginx && \
    mkdir /home/ambientum/ssl && \
    chown -R ambientum:ambientum /var/tmp/nginx && \
    chown -R ambientum:ambientum /var/run/nginx && \
    chown -R ambientum:ambientum /var/log/nginx && \
    chown -R ambientum:ambientum /var/lib/nginx && \
    chmod +x /home/ambientum/start.sh && \
    chown -R ambientum:ambientum /home/ambientum

# Define the running user
USER ambientum

# Pre generate some SSL
# YOU SHOULD REPLACE WITH YOUR OWN CERT.
RUN openssl req -x509 -nodes -days 3650 \
   -newkey rsa:2048 -keyout /home/ambientum/ssl/nginx.key \
   -out /home/ambientum/ssl/nginx.crt -subj "/C=AM/ST=Ambientum/L=Ambientum/O=Ambientum/CN=*.dev" && \
   openssl dhparam -out /home/ambientum/ssl/dhparam.pem 2048

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and nginx on foreground
CMD ["/home/ambientum/start.sh"]
