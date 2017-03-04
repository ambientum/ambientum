#!/usr/bin/env bash

# if the user wants to enable new relic
if [[ $NR_ENABLED == true ]]; then
	# set the new relic key
	sudo sed -i -e "s/"REPLACE_WITH_REAL_KEY"/$NR_LICENSE_KEY/g" /scripts/newrelic.ini
	# set the new relic application name
	sudo sed -i -e "s/PHP Application/$NR_APP_NAME/g" /scripts/newrelic.ini
	# enable new relic for fpm
	sudo cp /scripts/newrelic.ini /etc/php/7.0/fpm/conf.d/newrelic.ini
	# enable new relic for cli
	sudo cp /scripts/newrelic.ini /etc/php/7.0/cli/conf.d/newrelic.ini
fi

if [[ $XDEBUG_ENABLED == true ]]; then
    # enable xdebug extension
    sudo sed -i "/;zend_extension=xdebug.so/c\zend_extension=xdebug.so" /etc/php/7.0/mods-available/xdebug.ini

    # enable xdebug remote config
    echo "[xdebug]" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.remote_enable=1" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.remote_host=`/sbin/ip route|awk '/default/ { print $3 }'`" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.remote_port=9000" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.scream=0" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.cli_color=1" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo "xdebug.show_local_vars=1" | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini
    echo 'xdebug.idekey = "ambientum"' | sudo tee -a /etc/php/7.0/mods-available/xdebug.ini

fi

# run the original command
exec "$@"
