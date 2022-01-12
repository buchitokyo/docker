FROM nginx:1.20-alpine
# docker pull nginx:1.21.5-alpine

WORKDIR /

RUN set -ex && apk --no-cache add sudo
# ensure www-data user exists　adding www-data (user) to www-data(group)
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data ; \
  echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo 'www-data:www-data' | chpasswd && exit 0 ; exit 1

RUN touch /var/run/nginx.pid \ && \
  chmod 755 /var/run/nginx.pid  && \
  chown -R 82:www-data /var/run/nginx.pid && \
  chown -R 82:www-data /var/cache/nginx

USER www-data

CMD ["sudo", "nginx", "-g", "daemon off;"]
