#!/bin/bash

# alias framework.
sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

if [[ "${NGINX_LISTEN_MODE}" = "nginx" ]]; then
  # starts NGINX!
  nginx
elif [[ "${NGINX_LISTEN_MODE}" = "fpm" ]]; then
	# starts FPM
  /usr/sbin/php-fpm8 -y /etc/php8/php-fpm.conf -F -O 2>&1
else
  # starts FPM
  nohup /usr/sbin/php-fpm8 -y /etc/php8/php-fpm.conf -F -O > /dev/stdout 2>&1 &
  # starts NGINX!
  nginx
fi
