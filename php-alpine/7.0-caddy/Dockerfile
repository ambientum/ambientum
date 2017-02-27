###
# Ambientum
#
# Repository:    PHP
# Image:         PHP-FPM + Caddy
# Version:       7.0.x
# Strategy:      PHP From source (Base Imagem) + Caddy from Official Install Script
# Base distro:   Alpine 3.4
#
# Inspired by official PHP images.
#
FROM ambientum/php-alpine:7.0

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Reset user to root to allow software install
USER root

# Copy Caddyfile and entry script
COPY Caddyfile /home/ambientum/Caddyfile
COPY start.sh  /home/ambientum/start.sh

# Installs Caddy
RUN curl https://getcaddy.com | bash && \
    chmod +x /home/ambientum/start.sh && \
    chown -R ambientum:ambientum /home/ambientum

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and caddy on foreground
CMD ["/home/ambientum/start.sh"]
