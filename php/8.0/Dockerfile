###
# Ambientum
#
# Repository:    PHP
# Image:         CLI/Base
# Version:       8.0.x
# Strategy:      PHP From PHP-Alpine Repository (CODECASTS) (https://github.com/codecasts/php-alpine)
# Base distro:   Alpine 3.12
#
FROM alpine:3.12

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <iamhernandev@gmail.com>"

# Platform args.
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Avoid cache use when PHP version changes
ENV CURRENT_PHP_VERSION=8.0.13

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
    COMPOSER_PROCESS_TIMEOUT=1200 \
    NPM_PACKAGES="/home/ambientum/.cache/npm-packages" \
    NODE_PATH="/home/ambientum/.cache/npm-packages/lib/node_modules" \
    MANPATH="/home/ambientum/.cache/npm-packages/share/man:/usr/share/man" \
    PREFIX='/home/ambientum/.local'

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
    php8 \
    php8-apcu \
    php8-bcmath \
    php8-bz2 \
    php8-calendar \
    php8-curl \
    php8-ctype \
    php8-exif \
    php8-fpm \
    php8-gd \
    php8-gmp \
    php8-iconv \
    php8-imagick \
    php8-imap \
    php8-intl \
    php8-mbstring \
    php8-mysqli \
    php8-mysqlnd \
    php8-pdo_mysql \
    php8-memcached \
    php8-mongodb \
    php8-opcache \
    php8-pdo_pgsql \
    php8-pgsql \
    php8-posix \
    php8-redis \
    php8-soap \
    php8-sodium \
    php8-sqlite3 \
    php8-pdo_sqlite \
    php8-xdebug \
    php8-xml \
    php8-xmlreader \
    php8-openssl \
    php8-phar \
    php8-xsl \
    php8-zip \
    php8-zlib \
    php8-pcntl \
    php8-gettext \
    php8-cgi \
    php8-sockets \
    php8-pcov \
    php8-phpdbg && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    sudo ln -s /usr/bin/php8 /usr/bin/php && \
    sudo ln -s /usr/bin/php-cgi8 /usr/bin/php-cgi && \
    sudo ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm && \
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
    sed -i "/;error_log = .*/c\error_log = /dev/stderr" /etc/php8/php.ini && \
    sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php8/php.ini && \
    sed -i "/user = .*/c\user = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/^group = .*/c\group = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen.owner = .*/c\listen.owner = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen.group = .*/c\listen.group = ambientum" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;access.log = .*/c\access.log = /dev/stderr" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;decorate_workers_output = .*/c\decorate_workers_output = no" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php8/php-fpm.d/www.conf && \
    sed -i "/;log_level = .*/c\log_level = notice" /etc/php8/php-fpm.conf && \
    sed -i "/;log_limit = .*/c\log_limit = 16384" /etc/php8/php-fpm.conf && \
    sed -i "/pid = .*/c\;pid = /run/php/php8-fpm.pid" /etc/php8/php-fpm.conf && \
    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php8/php-fpm.conf && \
    sed -i "/error_log = .*/c\error_log = /dev/stderr" /etc/php8/php-fpm.conf && \
    sed -i "/;rlimit_files = .*/c\rlimit_files = 8192" /etc/php8/php-fpm.conf && \
    sed -i "/;rlimit_core = .*/c\rlimit_core = unlimited" /etc/php8/php-fpm.conf && \
    sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php8/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php8/php.ini && \
    sed -i "/zend_extension=xdebug/c\;zend_extension=xdebug" /etc/php8/conf.d/00_xdebug.ini && \
    chown -R ambientum:ambientum /home/ambientum && \
    chown -R ambientum:ambientum /scripts && \
    chmod +x /scripts/*.sh && \
    rm -rf /tmp/*

# Define the running user
USER ambientum

# Application directory
WORKDIR "/var/www/app"

# Environment variables
ENV PATH=/scripts:/home/ambientum/.local/bin:/home/ambientum/.cache/npm-packages/bin:/home/ambientum/.yarn/bin:/home/ambientum/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Define the entry point that tries to enable newrelic
ENTRYPOINT ["/scripts/entrypoint.sh"]

# As non daemon and single base image, it may be used as cli container
CMD ["/usr/bin/env", "ash"]
