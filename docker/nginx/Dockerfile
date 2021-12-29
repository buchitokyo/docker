FROM nginx:1.20-alpine

WORKDIR /

# ensure www-data user exists　adding www-data (user) to www-data(group)
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN touch /var/run/nginx.pid && \
  chown -R 82:www-data /var/run/nginx.pid && \
  chown -R 82:www-data /var/cache/nginx

USER www-data
