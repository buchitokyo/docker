FROM node:16.14.2-alpine3.15

RUN mkdir -p /var/www/client
# timezone
ARG TZ
WORKDIR /var/www/client
# COPY ./src/client/ /var/www/client

RUN apk update && \
    apk add --no-cache make gcc g++ python2 git
    # python && \
RUN yarn install

EXPOSE 3000

CMD [ "node", "server.js" ]
# CMD [ "yarn", "run", "dev" ]