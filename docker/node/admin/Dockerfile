FROM node:14.18.0-alpine

RUN mkdir -p /var/www/next/admin
# # timezone
ARG TZ
WORKDIR /var/www/next/admin
COPY ./src/next/admin/ /var/www/next/admin

RUN apk update && \
    apk add --no-cache make gcc g++ python
    # python && \
RUN yarn install

EXPOSE 3001

ENTRYPOINT ["yarn", "run", "dev"]