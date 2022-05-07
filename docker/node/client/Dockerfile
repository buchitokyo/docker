FROM node:14.18.0-alpine

RUN mkdir -p /var/www/next/client
# timezone
ARG TZ
WORKDIR /var/www/next/client
COPY ./src/next/client/ /var/www/next/client

RUN apk update && \
    apk add --no-cache make gcc g++ python
    # python && \
RUN yarn install

EXPOSE 3000

ENTRYPOINT ["yarn", "run", "dev"]