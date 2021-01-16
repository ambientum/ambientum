#!/bin/bash

sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

# Starts FPM
nohup /usr/sbin/php-fpm8 -y /etc/php8/php-fpm.conf -F -O > /dev/null 2>&1 &

# Starts NGINX!
nginx
