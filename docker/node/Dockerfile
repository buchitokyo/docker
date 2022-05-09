FROM node:14.18.0-alpine

RUN mkdir -p /var/www/client
# # timezone
ARG TZ
WORKDIR /var/www/client
# COPY ./src/client/ /var/www/client

RUN apk update && \
    apk add --no-cache make gcc g++ python
    # python && \
RUN yarn install

EXPOSE 3001

# ENTRYPOINT ["yarn", "run", "dev"]