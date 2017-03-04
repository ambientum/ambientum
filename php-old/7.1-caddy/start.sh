#!/bin/bash

# Starts FPM
nohup /usr/sbin/php-fpm7.1 -F -O 2>&1 &

# Starts caddy with the default configuration file
/usr/local/bin/caddy -conf /home/php-user/Caddyfile