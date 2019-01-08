#!/bin/bash

# start php-pm
/home/ambientum/ppm/vendor/bin/ppm \
 start \
 --host=0.0.0.0 \
 --bootstrap=$FRAMEWORK \
 --cgi-path=/usr/bin/php-cgi7 \
 --static-directory=/var/www/app/public \
 --debug=1 \
 /var/www/app
