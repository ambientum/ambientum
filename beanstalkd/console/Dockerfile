#####
# Ambientum 1.0
# Starts on Caddy PHP Image (Beanstalkd Console)
######
FROM ambientum/php:7.0-caddy

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <diego@hernandev.com>"

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---> Updating Repository" && \
    composer create ptrofimov/beanstalk_console /var/www/app
    
# Expose web Port
EXPOSE 8080