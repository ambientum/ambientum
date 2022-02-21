# replace HTTP port.
sudo sed -i "s/8080/${NGINX_HTTP_PORT}/g" /etc/nginx/sites/common.conf
# replace HTTPS pot.
sudo sed -i "s/8083/${NGINX_HTTPS_PORT}/g" /etc/nginx/sites/common.conf