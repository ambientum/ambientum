#!/bin/bash

# Starts FPM
nohup /usr/sbin/php-fpm -y /etc/php/7.0/fpm/php-fpm.conf -F -O 2>&1 &

# Starts caddy with the default configuration file
/usr/local/bin/caddy -conf /home/ambientum/Caddyfile