FROM --platform=$BUILDPLATFORM docker.io/alpine:3.21

ARG TARGETOS TARGETARCH
LABEL maintainer="tier940"

# Squid install
RUN apk update \
  && apk add --no-cache squid~=6.9-r0

# COPY squid-ssl-bump.conf /etc/squid/squid.conf
COPY squid.conf.opt /etc/squid/squid.conf
COPY lxc-whitelist /etc/squid/whitelist

# ssl-bump only
# COPY bump.crt /etc/squid/bump.crt
# COPY bump.key /etc/squid/bump.key
# COPY bump_dhparam.pem /etc/squid/bump_dhparam.pem
# RUN chown squid:squid /etc/squid/bump* \
#  && chmod 400 /etc/squid/bump* \
#  && mkdir -p /var/cache/squid/ \
#  && /usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 20MB \
#  && chown -R squid:squid /var/cache/squid/ssl_db



# Finalize
EXPOSE 3128
USER squid
WORKDIR /etc/squid/
ENTRYPOINT [ "/usr/sbin/squid" ]
CMD [ "-N", "-f", "/etc/squid/squid.conf" ]
