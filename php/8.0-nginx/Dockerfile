###
# Ambientum
#
# Repository:    PHP
# Image:         PHP-FPM + Nginx
# Version:       8.0.x
# Strategy:      PHP From PHP-Alpine Repository (CODECASTS) + Official Nginx
# Base distro:   Alpine 3.12
#
# Inspired by official PHP images.
#
FROM ambientum/php:8.0

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <iamhernandev@gmail.com>"

# Variables for enabling NewRelic
# set NGINX_MODE to 'http' or 'https' to disable the other one 
ENV NGINX_HTTP_PORT="8080" \
    NGINX_HTTPS_PORT="8083" \
    NGINX_MODE="dual" \
    NGINX_LISTEN_MODE="dual" \
    NGINX_FPM_BACKEND_HOST="127.0.0.1" \
    NGINX_FPM_BACKEND_PORT="9000"

# Reset user to root to allow software install
USER root

# copy config and start CMD.
COPY etc /etc
COPY scripts /scripts
COPY start.sh  /home/start.sh

# Install nginx from dotdeb (already enabled on base image)
RUN echo "--> Installing Nginx" && \
    apk add --update nginx openssl && \
    rm -rf /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    mkdir /var/tmp/nginx && \
    mkdir /var/run/nginx && \
    chown -R ambientum:ambientum /var/tmp/nginx && \
    chown -R ambientum:ambientum /var/run/nginx && \
    chown -R ambientum:ambientum /var/log/nginx && \
    chown -R ambientum:ambientum /var/lib/nginx && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /home/start.sh && \
    chmod +x /home/start.sh

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE ${NGINX_HTTP_PORT}
EXPOSE ${NGINX_HTTPS_PORT}

# Starts a single shell script that puts php-fpm as a daemon and nginx on foreground
CMD ["/home/start.sh"]
