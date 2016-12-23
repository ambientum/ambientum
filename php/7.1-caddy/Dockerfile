#####
# Ambientum 1.0
# PHP 7.0 bundled with the Awesome Caddy webserver
######
FROM ambientum/php:7.1

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Reset user to root to allow software install
USER root

# Installs Caddy
RUN curl https://getcaddy.com | bash

# Copy Caddyfile and entry script
COPY Caddyfile /home/php-user/Caddyfile
COPY start.sh  /home/php-user/start.sh

RUN chmod +x /home/php-user/start.sh && \
    chown -R php-user:php-user /home/php-user

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and caddy on foreground
CMD ["/home/php-user/start.sh"]
