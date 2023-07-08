FROM --platform=$BUILDPLATFORM docker.io/alpine:edge

# Squid install
ENV TZ=Asia/Tokyo
RUN apk update \
  && apk add --no-cache squid~=6.1-r0

COPY squid.conf /etc/squid/
COPY lxc-whitelist /etc/squid/whitelist
#COPY mycert.pem /etc/squid/mycert.pem
# RUN /usr/lib64/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 20MB



EXPOSE 3128
USER squid
ENTRYPOINT [ "/usr/sbin/squid" ]
CMD [ "-N", "-f", "/etc/squid/squid.conf" ]
