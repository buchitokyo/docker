FROM node:14.18.0-alpine

RUN mkdir -p /var/www/nuxt/client
# # timezone
ARG TZ
WORKDIR /var/www/nuxt/client
COPY ./src/nuxt/client/ /var/www/nuxt/client

RUN apk update && \
    apk add --no-cache make gcc g++ python
    # python && \
RUN yarn install

EXPOSE 3000

ENTRYPOINT ["yarn", "run", "dev"]