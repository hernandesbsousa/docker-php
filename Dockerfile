FROM debian:wheezy
MAINTAINER Hernandes Benevides de Sousa

# Install from dotdeb
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 89DF5277
RUN echo "deb http://packages.dotdeb.org wheezy-php56 all" > /etc/apt/sources.list.d/dotdeb.list

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -yq install \
        php5 \
        php5-apcu \
        php5-cli \
        php5-common \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-mysql \
         && \
    rm -rf /var/lib/apt/lists/*

COPY etc /etc

# Install Composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php \
    && \
    mv composer.phar /usr/local/bin/composer

EXPOSE 9000
CMD ["php5-fpm"]
