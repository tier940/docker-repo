FROM --platform=$BUILDPLATFORM docker.io/alpine:3.21

LABEL maintainer="tier940"

# Squid install
RUN apk update \
  && apk add --no-cache squid~=6.12-r0

COPY squid.conf.opt /etc/squid/squid.conf
COPY lxc-whitelist /etc/squid/whitelist

# Finalize
EXPOSE 3128
USER squid
WORKDIR /etc/squid/
ENTRYPOINT [ "/usr/sbin/squid" ]
CMD [ "-N", "-f", "/etc/squid/squid.conf" ]
