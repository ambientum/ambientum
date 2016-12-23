#!/bin/bash

# Starts FPM
nohup /usr/sbin/php-fpm7.1 -F -O 2>&1 &

# Starts nginx!
nginx
