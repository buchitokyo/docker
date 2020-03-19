FROM nginx:latest
ADD default.conf /etc/nginx/conf.d
ADD ssl /etc/nginx/ssl

RUN chmod 755 -R /var
RUN chmod 400 /etc/nginx/ssl/server.key

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
