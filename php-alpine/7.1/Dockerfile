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
    PHP_SOURCE_URL=https://secure.php.net/get/php-7.1.2.tar.xz/from/this/mirror


RUN echo "--------> Installing Image Utils <--------" && \
    apk add --no-cache --virtual .persistent-deps \
        bash \
        ca-certificates \
        curl \
        git \
        openssl \
        tar \
        xz \
        wget

RUN echo "--------> Downloading PHP Source <--------" && \
    wget -O /tmp/php.tar.xz $PHP_SOURCE_URL && \
    mkdir /tmp/php-src-cli && \
    mkdir /tmp/php-src-fpm && \
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-cli --strip-components=1 && \
    tar -Jxf /tmp/php.tar.xz -C /tmp/php-src-fpm --strip-components=1

RUN echo "--------> Downloading Build Dependencies & Preparing Build <--------" && \
    apk add --no-cache --virtual .build-deps \
        autoconf \
        file \
        g++ \
        gcc \
        libc-dev \
        icu-libs \
        libpq \
        make \
        pkgconf \
        re2c \
        curl-dev \
        libedit-dev \
        libxml2-dev \
        openssl-dev \
        sqlite-dev \
        libpng-dev \
        libjpeg && \
        export CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
        CPPFLAGS="$CFLAGS" \
        LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

RUN echo "--------> Configuring and Building PHP-CLI <--------" && \
    cd /tmp/php-src-cli && \
    ./configure \
        --prefix=/usr \
        --with-config-file-path="$PHP_INI_BASE_DIR/cli" \
        --with-config-file-scan-dir="$PHP_INI_BASE_DIR/cli/conf.d" \
        --with-gd \
        --with-mcrypt \
        --with-openssl \
        --with-pdo-mysql \
        --with-pdo-pgsql \
        --with-pgsql \
        --with-xmlrpc \
        --enable-bcmath \
        --enable-calendar \
        --enable-ftp \
        --enable-intl \
        --enable-mbstring \
        --enable-mysqlnd \
        --enable-opcache \
        --enable-soap \
        --enable-zip \
        --disable-cgi \
        --with-curl \
        --with-gd \
        --with-libedit \
        --with-pdo-mysql \
        --with-zlib && \
        make -j "$(getconf _NPROCESSORS_ONLN)" && \
        make install && \
        make clean


RUN adduser -D -u 1000 ambientum

RUN echo "--------> Configuring and Building PHP-FPM <--------" && \
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
        --with-gd \
        --with-mcrypt \
        --with-openssl \
        --with-pdo-mysql \
        --with-pdo-pgsql \
        --with-pgsql \
        --with-xmlrpc \
        --enable-bcmath \
        --enable-calendar \
        --enable-ftp \
        --enable-intl \
        --enable-mbstring \
        --enable-mysqlnd \
        --enable-opcache \
        --enable-soap \
        --enable-zip \
        --disable-cgi \
        --with-curl \
        --with-gd \
        --with-libedit \
        --with-pdo-mysql \
        --with-zlib && \
        make -j "$(getconf _NPROCESSORS_ONLN)" && \
        make install && \
        make clean

#RUN echo "--------> Cleaning UP <--------" && \
#    cd / && \
#    runDeps="$( \
#        scanelf --needed --nobanner --recursive /usr/local \
#            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
#            | sort -u \
#            | xargs -r apk info --installed \
#            | sort -u \
#    )" && \
#    apk add --no-cache --virtual .php-rundeps $runDeps && \
#    rm -rf /tmp/* && \
#    apk del .build-deps

# Add configuration files
ADD files/etc /etc





