FROM --platform=$BUILDPLATFORM docker.io/php:8.0-fpm

ARG TARGETOS TARGETARCH
LABEL maintainer="tier940"

RUN adduser nginx

# App install
ENV DEBCONF_NOWARNINGS=yes
RUN apt update \
    && apt install -y ca-certificates curl gnupg unzip libzip-dev mariadb-client wget git libpq-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && pecl install curl xdebug \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo_mysql opcache zip \
    && docker-php-ext-enable xdebug

# Node install
ENV NODE_VERSION=20
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_VERSION.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt update \
    && apt install -y nodejs \
    && apt -y autoremove \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /usr/lib/node_modules/ \
    && chown nginx:nginx /usr/lib/node_modules/ \
    && npm install -g yarn npm-check-updates

# Composer install
COPY --from=docker.io/composer /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# PHP Setup
COPY ./php/php.ini /usr/local/etc/php/php.ini
COPY ./php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf

RUN mkdir -p /var/run/php-fpm/ \
    && mkdir -p /composer/cache/ \
    && touch /var/log/xdebug.log \
    && touch /var/run/php-fpm/php-fpm.sock \
    && chown nginx:nginx -R /var/run/php-fpm/ \
    && chown nginx:nginx -R /composer/cache/ \
    && chown nginx:nginx /var/log/xdebug.log

USER nginx
WORKDIR /var/www/html
