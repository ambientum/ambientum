#!/bin/bash

# Starts FPM
nohup /usr/sbin/php-fpm -y /etc/php/7.1/fpm/php-fpm.conf -F -O 2>&1 &

# Starts nginx!
nginx
