#####
# Ambientum 1.0
# PHP 7.0 bundled with the Apache2 Web webserver
######
FROM ambientum/php:7.1

# Repository/Image Maintainer
MAINTAINER Vitor Souza <vsouza@virtualsystems.com.br>

# Reset user to root to allow software install
USER root

# Install apache2 from official repositories
RUN echo "---> Adding contrib and non-free components in source.list" && \
    sed -i "/main/s//main contrib non-free/" /etc/apt/sources.list && \
    echo "--> Updating Repository and Installing Apache2" && \
    apt-get update -y && \
    apt-get install -y \
    apache2 \
    apache2-mpm-worker \
    libapache2-mod-fastcgi && \
    echo "--> Disabling mods we don't need, and enabling those who need" && \
    a2dismod mpm_prefork mpm_event && \
    a2enmod actions fastcgi alias mpm_worker rewrite && \
    echo "--> Creating php7-fcgi" && \
    touch /var/lib/apache2/fastcgi/php7-fcgi && \
    echo "--> Cleaning up" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    chown -R php-user:php-user /var/run/apache2 && \
    chown -R php-user:php-user /var/log/apache2 && \
    chown -R php-user:php-user /var/lock/apache2 && \
    chown -R php-user:php-user /var/lib/apache2

# Copy apache, fastcgi and entry script
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ports.conf /etc/apache2/ports.conf
COPY fastcgi.conf /etc/apache2/mods-available/fastcgi.conf
COPY start.sh  /home/php-user/start.sh

RUN chmod +x /home/php-user/start.sh && \
    chown -R php-user:php-user /home/php-user

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and apache2 on foreground
CMD ["/home/php-user/start.sh"]
