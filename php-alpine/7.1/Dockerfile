###
# Ambientum
#
# Repository:    PHP
# Version:       7.1.x
# Strategy:      Build from source
# Base distro:   Alpine 3.4
#
# Inspired by official PHP images.
#

# set alpine as base image
FROM alpine:3.4

# define environment variables
ENV PHP_INI_BASE_DIR=/etc/php/7.1 \
    PHP_VERSION=7.1.2 \
    PHP_SOURCE_URL=http://br2.php.net/get/php-7.1.2.tar.xz/from/this/mirror \
    XDEBUG_ENABLED=false \
    NR_ENABLED=false \
    NR_APP_NAME="" \
    NR_LICENSE_KEY="" \
    PHP_ADD_EXT="bcmath bz2 calendar curl gd gettext gmp \
                            imap intl mbstring mcrypt opcache pcntl pdo_mysql \
                            pdo_pgsql pgsql soap xmlrpc zip"

# copy php example configuration files
COPY conf /etc/php/7.1
ADD start.sh /scripts/start.sh

# build in one big step
RUN echo "--------> Installing Image Utils <--------" && \
    apk add --no-cache --virtual .persistent-deps \
        bash \
        ca-certificates \
        curl \
        git \
        libxrender \
        fontconfig \
        nano \
        sudo \
        openssl \
        tar \
        xz \
        wget && \
    echo "--------> Downloading PHP Source <--------" && \
    wget -O /tmp/php.tar.xz $PHP_SOURCE_URL && \
    mkdir /tmp/php-src-cli && \
    mkdir /tmp/php-src-fpm && \
    mkdir /tmp/php-src-ext && \
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-cli --strip-components=1 && \
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-fpm --strip-components=1 && \
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-ext --strip-components=1 && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-cli/configure && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-cli/configure.in && \
    sed -i '/PHP_EXTRA_VERSION/s/""/"-ambientum"/' /tmp/php-src-cli/main/php_version.h && \
    sed -i '/PHP_VERSION "/s/"$/-ambientum"/' /tmp/php-src-cli/main/php_version.h && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-fpm/configure && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-fpm/configure.in && \
    sed -i '/PHP_EXTRA_VERSION/s/""/"-ambientum"/' /tmp/php-src-fpm/main/php_version.h && \
    sed -i '/PHP_VERSION "/s/"$/-ambientum"/' /tmp/php-src-fpm/main/php_version.h && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-ext/configure && \
    sed -i '/^PHP_EXTRA_VERSION/s/"$/-ambientum"/' /tmp/php-src-ext/configure.in && \
    sed -i '/PHP_EXTRA_VERSION/s/""/"-ambientum"/' /tmp/php-src-ext/main/php_version.h && \
    sed -i '/PHP_VERSION "/s/"$/-ambientum"/' /tmp/php-src-ext/main/php_version.h && \
    echo "--------> Downloading Build Dependencies & Preparing Build <--------" && \
    apk add --no-cache --virtual .build-deps \
        autoconf \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        libedit-dev \
        libxml2-dev \
        openssl-dev \
        sqlite-dev && \
        export CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
        CPPFLAGS="$CFLAGS" \
        LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" && \
    echo "--------> Configuring and Building PHP-CLI <--------" && \
    adduser -D -u 1000 ambientum && \
    mkdir -p /var/www/app && \
    chown -R ambientum:ambientum /var/www && \
    cd /tmp/php-src-cli && \
    ./configure \
        --prefix=/usr \
        --with-config-file-path="$PHP_INI_BASE_DIR/cli" \
        --with-config-file-scan-dir="$PHP_INI_BASE_DIR/cli/conf.d" \
        --with-openssl \
        --enable-mysqlnd \
        --disable-cgi \
        --with-libedit \
        --with-zlib && \
    make -j "$(getconf _NPROCESSORS_ONLN)" && \
    make install && \
    make clean && \
    echo "--------> Configuring and Building PHP-FPM <--------" && \
    cd /tmp/php-src-fpm && \
    ./configure \
        --prefix=/usr \
        --with-config-file-path="$PHP_INI_BASE_DIR/fpm" \
        --with-config-file-scan-dir="$PHP_INI_BASE_DIR/fpm/conf.d" \
        --disable-cli \
        --enable-fpm \
        --with-fpm-conf="$PHP_INI_BASE_DIR/fpm/php-fpm.conf" \
        --with-fpm-user=ambientum \
        --with-fpm-group=ambientum \
        --with-openssl \
        --enable-mysqlnd \
        --disable-cgi \
        --with-libedit \
        --with-zlib && \
    make -j "$(getconf _NPROCESSORS_ONLN)" && \
    make install && \
    make clean && \
    echo "--------> Building Extensions <--------" && \
    apk add --no-cache --virtual .ext-build-deps \
        curl-dev \
        bzip2-dev \
        libpng-dev \
        libjpeg \
        gettext-dev \
        gmp-dev \
        imap-dev \
        icu-dev \
        libmcrypt-dev \
        libpq \
        postgresql-dev && \
    for ext_name in $PHP_ADD_EXT; do cd /tmp/php-src-ext/ext/$ext_name && \
    phpize && \
    ./configure || exit 1 && \
    make && \
    make install; done && \
    echo "--------> Installing Composer <--------" && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo "--------> Adding Support for <--------" && \
    mkdir /tmp/newrelic && \
    cd /tmp/newrelic && \
    wget -r -l1 -nd -A"linux-musl.tar.gz" https://download.newrelic.com/php_agent/release/ && \
    gzip -dc newrelic*.tar.gz | tar xf - && \
    cd newrelic-php5* && \
    rm -f /usr/lib/php/20160303/newrelic.so && \
    cp ./agent/x64/newrelic-20160303.so /usr/lib/php/extensions/no-debug-non-zts-20160303/newrelic.so && \
    cp ./daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon && \
    cp ./scripts/newrelic.ini.template /scripts/newrelic.ini && \
    mkdir /var/log/newrelic && \
    chown -R ambientum:ambientum /var/log/newrelic && \
    chmod +x /scripts/start.sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--------> Installing Additional Extensions (PECL) <--------" && \
    pecl install xdebug && \
    pecl install redis && \
    echo "--------> Cleaning UP <--------" && \
    cd / && \
    runDeps="$( \
        scanelf --needed --nobanner --recursive /usr \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
        )" && \
    apk add --no-cache --virtual .php-rundeps $runDeps \
        libedit \
        libxml2 && \
    rm -rf /tmp/* && \
    apk del .ext-build-deps && \
    apk del .build-deps && \
    echo "--------> Making ambientum user a Super User <--------" && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

# fix fpm permissions for PHP
RUN wget -O /tini https://github.com/krallin/tini/releases/download/v0.14.0/tini-static && \
    mkdir /run/php && \
    chmod +x /tini && \
    chown -R ambientum:ambientum /run/php && \
    echo 'export PS1="\u@\h [\W] \\$ "' >> /root/.bashrc && \
    echo 'export PS1="\u@\h [\W] \\$ "' >> /home/ambientum/.bashrc && \
    chown ambientum:ambientum /home/ambientum/.bashrc

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

ENV PATH=/home/ambientum/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Define the entry point that tries to enable newrelic
ENTRYPOINT ["/tini", "--", "/scripts/start.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]