# ベースイメージ
FROM php:7.4.27-fpm-alpine3.15
# 生成するイメージのAuthor（作者）を指定
LABEL maintainer "kawabuchi"

ARG TZ
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_NO_INTERACTION 1
ENV COMPOSER_HOME /composer

# php fpm install alpineでなければ、apt-get
RUN set -eux && \
  apk --no-cache update && \
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
  build-base \
  # gcc \
  # g++ \
  # make \
  openssl \
  openssh \
  npm \
  nodejs\
  bash \
  vim \
  libzip-dev \
  zip \
  imagemagick \
  imagemagick-libs \
  imagemagick-dev \
  git && \
  apk add --update-cache --no-cache --virtual=.build-dependencies tzdata && \
  cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  apk del .build-dependencies && \
  docker-php-ext-install -j$(nproc) \
  exif \
  pcntl \
  iconv \
  intl \
  mbstring \
  sockets \
  ctype \
  json \
  bcmath \
  curl \
  dom \
  pdo \
  simplexml \
  zip \
  opcache \
  gd \
  # pdo_pgsql \
  mysqli \
  pdo_mysql && \
  # docker-php-ext-configure zip --with-libzip && \
  # docker-php-ext-install zip &&\
  # pecl install xdebug-2.7.0beta1 && \
  pecl install \
  imagick \
  redis && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-enable imagick && \
  # prdでは入れない(debug)
  # pecl install xdebug && \
  # docker-php-ext-enable xdebug && \
  docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ && \
    # --with-png=/usr/include/ && no more \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --1 --filename=composer && \
  composer config -g repos.packagist composer https://packagist.jp && \
  composer global require hirak/prestissimo && \
  rm -rf /var/cache/apk/*
# RUN pecl install mongodb \
#     &&  echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
