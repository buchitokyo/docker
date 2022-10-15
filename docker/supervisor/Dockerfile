# ベースイメージ
FROM php:8.1-fpm-alpine3.15

# RUN docker-php-ext-install pdo pdo_mysql

RUN apk update && apk add --no-cache supervisor

RUN mkdir -p /etc/supervisor/logs

COPY ./docker/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./docker/supervisor/supervisor_laravel.conf /etc/supervisor/conf.d/supervisor_laravel.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
# CMD ["/usr/bin/supervisord"]