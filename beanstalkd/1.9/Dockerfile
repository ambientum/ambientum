#####
# Ambientum 1.0
# Debian Jessie as Base Image (Beanstalkd from source)
######
FROM debian:jessie

# Repository/Image Maintainer
LABEL maintainer="Diego Hernandes <diego@hernandev.com>"

# Install PHP From DotDeb, Common Extensions, Composer and then cleanup
RUN echo "---> Updating Repository" && \
    apt-get update -y && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get upgrade -y && \
    apt-get install -y wget \
    unzip \
    build-essential && \
    echo "---> Downloading beanstalkd source" && \
    wget https://github.com/kr/beanstalkd/archive/v1.9.zip && \
    unzip v1.9.zip && \
    cd /beanstalkd-1.9 && \
    make && \
    make install && \
    cd / && rm -rf /beanstalkd-1.9 && \
    apt-get remove -y --purge build-essential \
    curl \
    unzip \
    build-essential && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Expose default benastalkd port
EXPOSE 11300

# Default command to start beanstalkd instance listening globally
CMD ["/usr/local/bin/beanstalkd", "-l", "0.0.0.0", "-p", "11300"]
