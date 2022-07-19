FROM node:16.14.2-alpine3.15

RUN mkdir -p /var/www/client
# # timezone
ARG TZ
WORKDIR /var/www/client
# COPY ./src/client/ /var/www/client

RUN apk update && \
    apk add --no-cache make gcc g++ python2
    # python && \
RUN yarn install

EXPOSE 3001

ENTRYPOINT ["node", "server.js"]
# CMD [ "yarn", "run", "dev" ]