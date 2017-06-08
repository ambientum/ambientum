#!/bin/bash

# Starts FPM
nohup /usr/sbin/php-fpm7 -y /etc/php7/php-fpm.conf -F -O 2>&1 &

# check if there is a SSL certificate available
FILE="/home/ambientum/ssl/nginx.crt"
if [ -f $FILE ]; then
   echo "SSL file found!"
else
   echo "No SSL Certificate found. generating..."
   openssl req -x509 -nodes -days 3650 \
   -newkey rsa:2048 -keyout /home/ambientum/ssl/nginx.key \
   -out /home/ambientum/ssl/nginx.crt -subj "/C=AM/ST=Ambientum/L=Ambientum/O=Ambientum/CN=*.dev"
fi

# check for DH


FILE=""
if [ -f "/home/ambientum/ssl/dhparam.pem" ]; then
   echo "dhparam.pem file found!"
else
   openssl dhparam -out /home/ambientum/ssl/dhparam.pem 2048
fi

# Starts nginx!
nginx
