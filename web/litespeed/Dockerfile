FROM ubuntu:20.04

# Init
ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION=lsphp81


# Install package
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y build-essential libexpat1-dev libgeoip-dev libpcre3-dev zlib1g-dev libssl-dev libxml2-dev rcs libpng-dev wget


# Install openlitespeed
RUN wget http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh && \
  bash enable_lst_debian_repo.sh && \
  rm /enable_lst_debian_repo.sh && \
  apt-get install -y openlitespeed mysql-client $PHP_VERSION $PHP_VERSION-common $PHP_VERSION-mysql $PHP_VERSION-opcache $PHP_VERSION-curl $PHP_VERSION-imagick $PHP_VERSION-redis $PHP_VERSION-memcached $PHP_VERSION-intl && \
  useradd -d /home/container -m container && \
  chown -R container:container /usr/local/lsws/ && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/*

COPY lsws/htpasswd /usr/local/lsws/admin/conf/htpasswd
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh



# Finalize
USER container
ENTRYPOINT [ "/entrypoint.sh" ]
# ENTRYPOINT [ "/usr/local/lsws/bin/lswsctrl" ]
# CMD [ "start" ]
WORKDIR /usr/local/lsws/
