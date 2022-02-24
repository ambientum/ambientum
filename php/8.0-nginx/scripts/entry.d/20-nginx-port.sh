#!/usr/bin/env ash

# Comment out HTTP/HTTPS listener

if [[ "${NGINX_MODE}" = "https" ]]; then
	sudo sed -i 's/^\(listen[][ :]*8080.*\)/#\1/g' /etc/nginx/sites/common.conf
elif [[ "${NGINX_MODE}" = "http" ]]; then
	sudo sed -i 's/^\(listen[][ :]*8083.*\)/#\1/g' /etc/nginx/sites/common.conf
fi

# replace HTTP port.
sudo sed -i "s/8080/${NGINX_HTTP_PORT}/g" /etc/nginx/sites/common.conf
# replace HTTPS pot.
sudo sed -i "s/8083/${NGINX_HTTPS_PORT}/g" /etc/nginx/sites/common.conf
