#!/bin/bash

# alias framework.
sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

if [[ "${NGINX_LISTEN_MODE}" = "nginx" ]]; then
  # starts NGINX!
  nginx
elif [[ "${NGINX_LISTEN_MODE}" = "fpm" ]]; then
	# starts FPM
  /usr/sbin/php-fpm7 -y /etc/php7/php-fpm.conf -F -O
else
  # starts FPM
  nohup /usr/sbin/php-fpm7 -y /etc/php7/php-fpm.conf -F -O > /dev/null 2>&1 &
  # starts NGINX!
  nginx
fi
