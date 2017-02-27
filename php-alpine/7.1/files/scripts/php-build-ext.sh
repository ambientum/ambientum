#!/bin/bash

## Available Extensions that are not bundle on compiled php
#
# bcmath bz2 calendar com_dotnet curl dba enchant
# exif ftp gd gettext gmp imap interbase intl ldap
# mbstring mcrypt mysqli oci8 odbc opcache pcntl
# pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc
# pdo_pgsql pgsql pspell recode shmop skeleton snmp
# soap sockets sysvmsg sysvsem sysvshm tidy wddx
# xmlrpc xsl zip
#
##

PHP_SOURCE_URL=https://secure.php.net/get/php-7.1.2.tar.xz/from/this/mirror

function prepare_php_source()
{
    # create the directory where build will take place
    mkdir -p /tmp/php-src-ext
    # download the source code
    wget -O /tmp/php.tar.xz $PHP_SOURCE_URL
    # extract it to the temporary directory
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-ext --strip-components=1
}

# prepare and download php source for the builds
#prepare_php_source

for ext_name in $PHP_ENABLED_EXTENSIONS; do cd /tmp/php-src-ext/etc/$ext_name && phpize && ./configure && make && make install; done
    echo -e "\n Installing: $extension_name \n\n"
    cd /tmp/php-src-ext/ext/$extension_name
    echo "cd /tmp/php-src-ext/ext/$extension_name"
    phpize
    ./configure
    make
    make install
done



