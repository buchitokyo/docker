FROM node:14.18.0-alpine

RUN mkdir -p /var/www/nuxt/admin
# # timezone
ARG TZ
WORKDIR /var/www/nuxt/admin
COPY ./src/nuxt/admin/ /var/www/nuxt/admin

RUN apk update && \
    apk add --no-cache make gcc g++ python
    # python && \
RUN yarn install

EXPOSE 3001

ENTRYPOINT ["yarn", "run", "dev"]