FROM --platform=$BUILDPLATFORM docker.io/ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TARGETOS TARGETARCH
ENV container docker
LABEL maintainer="tier940"

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \ 
        software-properties-common gpg-agent systemd systemd-cron \
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y --no-install-recommends ansible \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
        rm -f /lib/systemd/system/multi-user.target.wants/*; \
        rm -f /etc/systemd/system/*.wants/*; \
        rm -f /lib/systemd/system/local-fs.target.wants/*; \
        rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
        rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
        rm -f /lib/systemd/system/basic.target.wants/*; \
        rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /root/work
VOLUME ["/tmp", "/run", "/run/lock"]
CMD ["/lib/systemd/systemd"]
