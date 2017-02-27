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
    PHP_SOURCE_URL=https://secure.php.net/get/php-7.1.2.tar.xz/from/this/mirror \
    PHP_ADD_EXT="bcmath bz2 calendar curl gd gettext gmp \
                            imap intl mbstring mcrypt opcache pcntl pdo_mysql \
                            pdo_pgsql pgsql soap xmlrpc zip"

# copy php example configuration files
COPY conf /etc/php/7.1

# build in one big step
RUN echo "--------> Installing Image Utils <--------" && \
    apk add --no-cache --virtual .persistent-deps \
        bash \
        ca-certificates \
        curl \
        git \
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
    apk del .build-deps