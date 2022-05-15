FROM alpine:3

RUN apk update \
  && apk add --no-cache squid~=5.2

COPY squid.conf /etc/squid/
COPY lxc-whitelist /etc/squid/whitelist
#COPY mycert.pem /etc/squid/mycert.pem
# RUN /usr/lib64/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 20MB

ENV TZ=Asia/Tokyo \
  http_proxy=http://localhost:3128 \
  https_proxy=http://localhost:3128

EXPOSE 3128
USER squid
ENTRYPOINT [ "/usr/sbin/squid" ]
CMD [ "-N", "-f", "/etc/squid/squid.conf" ]
