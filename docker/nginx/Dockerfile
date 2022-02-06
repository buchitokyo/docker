FROM centos:centos8

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

RUN dnf -y update
RUN dnf install -y nginx
RUN dnf -y install sudo

WORKDIR /

ARG UID=82
ARG GID=82
RUN useradd -u $UID -o -m www-data
RUN groupmod -g $GID -o www-data
RUN echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo 'www-data:www-data' | chpasswd && exit 0 ; exit 1

RUN mkdir -p /var/cache/nginx
RUN touch /var/run/nginx.pid \ && \
  chmod 755 /var/run/nginx.pid  && \
  chown -R 82:www-data /var/run/nginx.pid && \
  chown -R 82:www-data /var/cache/nginx

USER www-data

CMD ["sudo", "nginx", "-g", "daemon off;"]