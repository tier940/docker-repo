FROM ubuntu:20.04

ARG OLS_VERSION=1.7.16
ARG PHP_VERSION=lsphp81


# Install package
RUN apt-get update && apt-get install -y wget curl cron tzdata


# Install openlitespeed
RUN wget https://openlitespeed.org/preuse/openlitespeed-$OLS_VERSION.tgz && \
  tar xzf openlitespeed-$OLS_VERSION.tgz && cd openlitespeed && ./install.sh && \
  echo 'cloud-docker' > /usr/local/lsws/PLAT && rm -rf /openlitespeed && rm /openlitespeed-$OLS_VERSION.tgz && \
  apt-get install -y mysql-client $PHP_VERSION $PHP_VERSION-common $PHP_VERSION-mysql $PHP_VERSION-opcache \
  $PHP_VERSION-curl $PHP_VERSION-imagick $PHP_VERSION-redis $PHP_VERSION-memcached $PHP_VERSION-intl && \
  wget -O /usr/local/lsws/admin/misc/lsup.sh https://raw.githubusercontent.com/litespeedtech/openlitespeed/master/dist/admin/misc/lsup.sh && \
  chmod +x /usr/local/lsws/admin/misc/lsup.sh && \
  ln -s /usr/local/lsws/$PHP_VERSION/bin/php /usr/bin/php && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/*

ADD docker.conf /usr/local/lsws/conf/templates/docker.conf
ADD setup_docker.sh /usr/local/lsws/bin/setup_docker.sh
ADD httpd_config.xml /usr/local/lsws/conf/httpd_config.xml
ADD htpasswd /usr/local/lsws/admin/conf/htpasswd


# Setup PHP
RUN /usr/local/lsws/bin/setup_docker.sh && \
  rm /usr/local/lsws/bin/setup_docker.sh && \
  chown 999:999 /usr/local/lsws/conf -R && \
  cp -RP /usr/local/lsws/conf/ /usr/local/lsws/.conf/ && \
  cp -RP /usr/local/lsws/admin/conf /usr/local/lsws/admin/.conf/ && \
  sed -i "s|fcgi-bin/lsphp|/usr/local/lsws/$PHP_VERSION/bin/lsphp|g" /usr/local/lsws/conf/httpd_config.conf && \
  ln -sf /usr/local/lsws/$PHP_VERSION/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp8 && \
  ln -sf /usr/local/lsws/fcgi-bin/lsphp8 /usr/local/lsws/fcgi-bin/lsphp



# Finalize
EXPOSE 7080 80 443
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /var/www/vhosts/
