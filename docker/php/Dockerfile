# ベースイメージ
FROM php:8.1-fpm-alpine3.15
# 生成するイメージのAuthor（作者）を指定
LABEL maintainer "kawabuchi"

ARG TZ
ARG SSH_PRIVATE_KEY

# php fpm install alpineでなければ、apt-get
RUN set -ex && apk --no-cache add sudo

RUN apk add --no-cache bash wget

# npm yarn nodejs
RUN apk add --no-cache yarn npm nodejs
RUN npm install -g @vue/cli \
  npm install -g npm@latest

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
  python3 \
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
RUN docker-php-ext-install -j$(nproc) \
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
#   opcache \
#   gd \
#   # pdo_pgsql \
#   mysqli \
  pdo_mysql \
  zip \
  gd

RUN pecl install \
  redis
# mongodb \
# && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

RUN pecl install xdebug phpredis && \
  docker-php-ext-enable xdebug \
  && rm -rf /tmp/* /var/cache/apk/*

# RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
#   rm -rf /tmp/*

# Install composer
COPY --from=composer:2.1.12 /usr/bin/composer /usr/bin/composer
# ENV COMPOSER_HOME /composer
# ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
# ENV COMPOSER_NO_INTERACTION 1
# ENV COMPOSER_ALLOW_SUPERUSER 1
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --1 --filename=composer && \
#   composer config -g repos.packagist composer https://packagist.jp && \
#   composer global require hirak/prestissimo && \
#   rm -rf /var/cache/apk/*
# ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# composer permission denied
# www-data user : root group (top)
# root user : www-data group (bottom)
# RUN chown -R www-data $COMPOSER_HOME
# RUN chown -R root:www-data $COMPOSER_HOME

WORKDIR /var/www

# RUN apk --no-cache add shadow && adduser -D -H -u ${ID} -s /bin/bash ${USER_NAME} -G ${USER_NAME} && \
#     gpasswd -a $USER_NAME sudo && \
#     echo "${USER_NAME}:${PASSWD}" | chpasswd && \
#     echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers

ARG UID=82
ARG GID=82
RUN set -ex && apk --no-cache add sudo
# *shadow that brings useradd & usermod. usermod -aG www-data nginx
RUN apk --no-cache add shadow && usermod -u $UID www-data && groupmod -g $GID www-data
RUN echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo 'www-data:www-data' | chpasswd && exit 0 ; exit 1;

RUN mkdir /home/www-data/.ssh/ && \
   echo "${SSH_PRIVATE_KEY}" > /home/www-data/.ssh/id_rsa && \
   chmod 600 /home/www-data/.ssh/id_rsa && \
   touch /home/www-data/.ssh/known_hosts && \
   ssh-keyscan github.com >> /home/www-data/.ssh/known_hosts && \
   chown -R www-data:www-data /home/www-data

RUN mkdir -p /var/run/php-fpm
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/cache/nginx

RUN chown -R www-data:www-data /var/www/ \
  && chown -R www-data:www-data /var/run/ \
  && chown -R www-data:www-data /var/log/

USER www-data