#####
# Ambientum 1.0
# PHP 7.0 bundled with the Awesome Caddy webserver
######
FROM ambientum/php:7.1

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
