#!/usr/bin/env ash

# OPCache extreme mode.
if [[ $OPCACHE_MODE == "extreme" ]]; then
    # enable extreme caching for OPCache.
    echo "opcache.enable=1" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.memory_consumption=512" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.interned_strings_buffer=128" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.max_accelerated_files=32531" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.validate_timestamps=0" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.save_comments=1" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
    echo "opcache.fast_shutdown=0" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
fi

# OPCache disabled mode.
if [[ $OPCACHE_MODE == "disabled" ]]; then
    # disable extension.
    sudo sed -i "/zend_extension=opcache/c\;zend_extension=opcache" /etc/php8/conf.d/00_opcache.ini
    # set enabled as zero, case extension still gets loaded (by other extension).
    echo "opcache.enable=0" | sudo tee -a /etc/php8/conf.d/00_opcache.ini > /dev/null
fi