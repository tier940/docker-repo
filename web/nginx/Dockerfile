FROM --platform=$BUILDPLATFORM docker.io/nginx:alpine3.18-slim

LABEL maintainer="tier940"

# Nginx setup
COPY ./nginx.conf /etc/nginx/
COPY ./conf.d/default.conf /etc/nginx/conf.d/
RUN touch /var/run/nginx.pid \
    && mkdir -p /var/www/html \
    && mkdir -p /var/cache/nginx \
    && chown nginx:nginx /var/run/nginx.pid \
    && chown nginx:nginx -R /var/www/html \
    && chown nginx:nginx -R /var/cache/nginx

USER nginx
WORKDIR /etc/nginx
ENTRYPOINT [ "/usr/sbin/nginx" ]
