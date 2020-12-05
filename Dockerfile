# Base image
FROM php:8-apache

# Install the necessary dependencies for the PHP and wget extensions
RUN apt-get update && apt-get install --no-install-recommends -yq ${BUILD_PACKAGES} \
        build-essential \
        ssh \
        vim \
        wget \
        unzip \
        libmcrypt-dev \
        libicu-dev \
        libzip-dev \
    && apt-get clean

# Definition of a PHP_EXTENSIONS environment variable
ENV PHP_EXTENSIONS opcache pdo_mysql pcntl intl zip
# Installation of the various extensions => {PHP_EXTENSIONS}
RUN docker-php-ext-install ${PHP_EXTENSIONS}

# Installation of composer
ENV COMPOSER_ALLOW_SUPERUSER=1
# Download composer + alias command composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

# Enabling Apache mod_rewrite
RUN a2enmod rewrite

# We entrust a vhost so as not to have / public in the url
# Copy from vhost to 000-default.conf
COPY docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf
