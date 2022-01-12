# ベースイメージ
FROM php:8.0-fpm-alpine3.15
# 生成するイメージのAuthor（作者）を指定
LABEL maintainer "kawabuchi"

ARG TZ

# php fpm install alpineでなければ、apt-get
RUN set -ex && apk --no-cache add sudo

RUN apk add --no-cache bash wget

# npm yarn nodejs
RUN apk add --no-cache yarn npm nodejs
RUN npm install -g @vue/cli
  # npm install -g npm@latest \

RUN set -eux && \
  apk --no-cache update &&\
  apk --no-cache add \
  oniguruma-dev \
  curl-dev \
  icu-dev \
  freetype-dev \
  rabbitmq-c \
  rabbitmq-c-dev \
  # libonig-dev \
  libpng-dev \
  libzip-dev \
  libjpeg-turbo-dev \
  libxml2-dev \
  zlib-dev \
  pcre-dev \
  autoconf \
  # build-base \
  gcc \
  g++ \
  make \
  openssl \
  openssh \
  vim \
  libzip-dev \
  zip \
  imagemagick \
  # imagemagick-libs \
  imagemagick-dev \
  su-exec \
  git

RUN apk add --update-cache --no-cache --virtual=.build-dependencies tzdata && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime

RUN apk del .build-dependencies

# すでにimageに入ってる
# RUN docker-php-ext-install -j$(nproc) \
#   exif \
#   pcntl \
#   iconv \
#   intl \
#   mbstring \
#   sockets \
#   ctype \
#   json \
#   bcmath \
#   curl \
#   dom \
#   pdo \
#   simplexml \
#   zip \
#   opcache \
#   gd \
#   # pdo_pgsql \
#   mysqli \
#   pdo_mysql

#   # RUN docker-php-ext-configure zip --with-libzip && \
#   # docker-php-ext-install zip &&\

RUN pecl install \
  imagick \
  redis
#   # mongodb \
#   # && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

RUN docker-php-ext-enable imagick \
  && rm -rf /tmp/* /var/cache/apk/*
#   # prdでは入れない(debug)
#   # pecl install xdebug && \
#   # docker-php-ext-enable xdebug && \
#   docker-php-ext-configure gd \
#     --with-freetype=/usr/include/ \
#     --with-jpeg=/usr/include/
    # --with-png=/usr/include/ && no more \

# RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
#   rm -rf /tmp/*

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_NO_INTERACTION 1
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --1 --filename=composer && \
  composer config -g repos.packagist composer https://packagist.jp && \
  composer global require hirak/prestissimo && \
  rm -rf /var/cache/apk/*
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# composer permission denied
# www-data user : root group (top)
# root user : www-data group (bottom)
RUN chown -R www-data $COMPOSER_HOME
# RUN chown -R root:www-data $COMPOSER_HOME

WORKDIR /var/www

# RUN apk --no-cache add shadow && adduser -D -H -u ${ID} -s /bin/bash ${USER_NAME} -G ${USER_NAME} && \
#     gpasswd -a $USER_NAME sudo && \
#     echo "${USER_NAME}:${PASSWD}" | chpasswd && \
#     echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers

RUN mkdir -p /var/run/php-fpm
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/cache/nginx

RUN chown -R www-data:www-data /var/www/ \
  && chown -R www-data:www-data /var/run/ \
  && chown -R www-data:www-data /var/log/

USER www-data
