FROM --platform=$BUILDPLATFORM docker.io/nginx:stable-alpine

# Nginx setup
COPY ./nginx.conf /etc/nginx/
COPY ./conf.d/default.conf /etc/nginx/conf.d/
RUN touch /var/run/nginx.pid \
    && mkdir -p /var/www/html \
    && mkdir -p /var/cache/nginx \
    && mkdir -p /etc/systemd/system/nginx.service.d/ \
    && chown nginx:nginx /var/run/nginx.pid \
    && chown nginx:nginx -R /var/www/html \
    && chown nginx:nginx -R /var/cache/nginx

COPY ./nginx.service.d/override.conf /etc/systemd/system/nginx.service.d/override.conf



USER nginx
WORKDIR /etc/nginx
ENTRYPOINT [ "/usr/sbin/nginx" ]
