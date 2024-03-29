###
# Ambientum
#
# Repository:    PHP
# Image:         CLI/Base
# Version:       7.3.x
# Strategy:      PHP From PHP-Alpine Repository (CODECASTS) (https://github.com/codecasts/php-alpine)
# Base distro:   Alpine 3.11
#
FROM alpine:3.11

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <iamhernandev@gmail.com>"

# Platform args.
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Avoid cache use when PHP version changes
ENV CURRENT_PHP_VERSION=7.3.33

# Variables for enabling NewRelic
ENV ENV="/etc/profile" \
    FRAMEWORK=laravel \
    CAROOT=/home/ambientum/.mkcert \
    SSL_DOMAIN="ambientum.localhost" \
    OPCACHE_MODE="normal" \
    PHP_MEMORY_LIMIT=256M \
    XDEBUG_ENABLED=false \
    XDEBUG_IDE_KEY="ambientum" \
    NR_ENABLED=false \
    NR_APP_NAME="" \
    NR_LICENSE_KEY="" \
    TERM=xterm-256color \
    COLORTERM=truecolor \
    COMPOSER_PROCESS_TIMEOUT=1200

# Add the ENTRYPOINT script
COPY etc /etc
COPY scripts /scripts

# copy mkcert binary from mkcert image.
COPY --from=ambientum/mkcert:1.4 /bin/mkcert /bin/mkcert

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---> Enabling PHP-Alpine" && \
    apk add --update \
    gettext \
    less \
    ca-certificates \
    tar \
    xz \
    jq \
    wget \
    curl \
    openssh \
    bash \
    fontconfig \
    libxrender \
    libxext \
    imagemagick \
    nano \
    vim \
    git \
    unzip \
    wget \
    make \
    sudo \
    s6 && \
    echo "---> Installing static FFMpeg binaries" && \
    export FFMPEG_PLATFORM=$(echo $TARGETPLATFORM | sed 's/linux\///g') && \
    wget -O /tmp/ffmpeg.tar.xz "https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.4-${FFMPEG_PLATFORM}-static.tar.xz" && \
    tar --directory=/tmp -xvf /tmp/ffmpeg.tar.xz && \
    mv "/tmp/ffmpeg-4.4-${FFMPEG_PLATFORM}-static/ffmpeg" /bin/ffmpeg && \
    mv "/tmp/ffmpeg-4.4-${FFMPEG_PLATFORM}-static/ffprobe" /bin/ffprobe && \
    mv "/tmp/ffmpeg-4.4-${FFMPEG_PLATFORM}-static/qt-faststart" /bin/qt-faststart && \
    rm -rf /tmp/ffmpeg* && \
    echo "---> Preparing and Installing PHP" && \
    apk add --update \
    php7@php \
    php7-common@php \
    php7-apcu@php \
    php7-bcmath@php \
    php7-bz2@php \
    php7-calendar@php \
    php7-curl@php \
    php7-ctype@php \
    php7-exif@php \
    php7-fpm@php \
    php7-gd@php \
    php7-gmp@php \
    php7-iconv@php \
    php7-imagick@php \
    php7-imap@php \
    php7-intl@php \
    php7-json@php \
    php7-mbstring@php \
    php7-mysqli@php \
    php7-mysqlnd@php \
    php7-pdo_mysql@php \
    php7-memcached@php \
    php7-mongodb@php \
    php7-opcache@php \
    php7-pdo_pgsql@php \
    php7-pgsql@php \
    php7-posix@php \
    php7-redis@php \
    php7-soap@php \
    php7-sodium@php \
    php7-sqlite3@php \
    php7-pdo_sqlite@php \
    php7-xdebug@php \
    php7-xml@php \
    php7-xmlreader@php \
    php7-openssl@php \
    php7-phar@php \
    php7-xsl@php \
    php7-zip@php \
    php7-zlib@php \
    php7-pcntl@php \
    php7-gettext@php \
    php7-cgi@php \
    php7-zlib@php \
    php7-pcov@php \
    php7-sockets@php \
    php7-phpdbg@php && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    sudo ln -s /usr/bin/php7 /usr/bin/php && \
    sudo ln -s /usr/bin/php-cgi7 /usr/bin/php-cgi && \
    sudo ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm && \
    echo "---> Installing Composer" && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo "---> Cleaning up" && \
    rm -rf /tmp/* && \
    echo "---> Adding the ambientum user" && \
    adduser -D -u 1000 ambientum && \
    mkdir -p /var/www/app && \
    mkdir -p /home/ssl && \
    chown -R ambientum:ambientum /var/www && \
    chown -R ambientum:ambientum /home/ssl && \
    echo "---> Configuring PHP" && \
    echo "ambientum  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i "/;error_log = .*/c\error_log = /dev/stderr" /etc/php7/php.ini && \
    sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php7/php.ini && \
    sed -i "/user = .*/c\user = ambientum" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/^group = .*/c\group = ambientum" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/listen.owner = .*/c\listen.owner = ambientum" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/listen.group = .*/c\listen.group = ambientum" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/;access.log = .*/c\access.log = /dev/stderr" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/;decorate_workers_output = .*/c\decorate_workers_output = no" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php7/php-fpm.d/www.conf && \
    sed -i "/;log_level = .*/c\log_level = notice" /etc/php7/php-fpm.conf && \
    sed -i "/;log_limit = .*/c\log_limit = 16384" /etc/php7/php-fpm.conf && \
    sed -i "/pid = .*/c\;pid = /run/php/php7-fpm.pid" /etc/php7/php-fpm.conf && \
    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php7/php-fpm.conf && \
    sed -i "/error_log = .*/c\error_log = /dev/stderr" /etc/php7/php-fpm.conf && \
    sed -i "/;rlimit_files = .*/c\rlimit_files = 8192" /etc/php7/php-fpm.conf && \
    sed -i "/;rlimit_core = .*/c\rlimit_core = unlimited" /etc/php7/php-fpm.conf && \
    sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php7/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php7/php.ini && \
    sed -i "/zend_extension=xdebug/c\;zend_extension=xdebug" /etc/php7/conf.d/00_xdebug.ini && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /scripts && \
    chmod +x /scripts/*.sh && \
    rm -rf /tmp/*

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Environment variables
ENV PATH=/scripts:/home/ambientum/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Define the entry point that tries to enable newrelic
ENTRYPOINT ["/scripts/entrypoint.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/usr/bin/env", "ash"]
