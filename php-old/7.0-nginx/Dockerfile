#####
# Ambientum 1.0
# PHP 7.0 bundled with the Nginx webserver
######
FROM ambientum/php:7.0

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Reset user to root to allow software install
USER root

# Install nginx from dotdeb (already enabled on base image)
RUN echo "--> Updating Repository and Installing Nginx" && \
    apt-get update -y && \
    apt-get install -y nginx && \
    echo "--> Cleaning up" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    mkdir /var/run/nginx && \
    chown -R php-user:php-user /var/run/nginx && \
    chown -R php-user:php-user /var/log/nginx && \
    chown -R php-user:php-user /var/lib/nginx

# Copy nginx and entry script
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh  /home/php-user/start.sh

RUN chmod +x /home/php-user/start.sh && \
    chown -R php-user:php-user /home/php-user

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and nginx on foreground
CMD ["/home/php-user/start.sh"]
