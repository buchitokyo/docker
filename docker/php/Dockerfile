# ベースイメージ
FROM php:7.3-fpm-alpine
# 生成するイメージのAuthor（作者）を指定
LABEL maintainer "buchi"

ARG TZ
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

# php fpm install alpineでなければ、apt-get
RUN set -eux && \
  apk --no-cache update && \
  apk --no-cache add \
  curl-dev \
  freetype-dev \
  libpng-dev\
  zlib-dev\
  libzip-dev\
  libjpeg-turbo-dev \
  libxml2-dev \
  zlib-dev \
  pcre-dev \
  g++ \
  make \
  autoconf \
  openssl \
  openssh \
  nodejs-npm \
  nodejs\
  bash \
  vim \
  git && \
  apk add --update-cache --no-cache --virtual=.build-dependencies tzdata && \
  cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  apk del .build-dependencies && \
  docker-php-ext-install \
  bcmath\
  curl \
  dom \
  mbstring \
  pdo \
  simplexml \
  zip \
  opcache \
  pdo_mysql && \
  docker-php-ext-configure zip --with-libzip &&\
  docker-php-ext-install zip &&\
  docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ && \
  docker-php-ext-install gd && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
  composer config -g repos.packagist composer https://packagist.jp && \
  composer global require hirak/prestissimo &&\
  rm -rf /var/cache/apk/*

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
