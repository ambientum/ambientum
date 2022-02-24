#!/usr/bin/env ash

if [[ $XDEBUG_ENABLED == true ]]; then
    # enable xdebug extension
    sudo sed -i "/;zend_extension=xdebug/c\zend_extension=xdebug" /etc/php8/conf.d/00_xdebug.ini

    # enable xdebug remote config
    echo "[xdebug]" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_enable=1" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_autostart=1" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    # shellcheck disable=SC2006
    echo "xdebug.remote_host=host.docker.internal" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_port=9000" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.scream=0" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.cli_color=1" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.show_local_vars=1" | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
    echo 'xdebug.idekey = "'${XDEBUG_IDE_KEY:-ambientum}'"' | sudo tee -a /etc/php8/conf.d/00_xdebug.ini > /dev/null
fi