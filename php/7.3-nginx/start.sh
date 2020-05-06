#!/bin/bash

# Regenerate SSL certificate if different than default one.
if [[ $SSL_DOMAIN != "ambientum.local" ]]; then
    /bin/mkcert -cert-file=/home/ssl/nginx.crt -key-file=/home/ssl/nginx.key "${SSL_DOMAIN}"
fi

sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

# Starts FPM
nohup /usr/sbin/php-fpm7 -y /etc/php7/php-fpm.conf -F -O 2>&1 &

# Starts NGINX!
nginx
