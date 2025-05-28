FROM --platform=$BUILDPLATFORM docker.io/almalinux:10.0

ARG TARGETOS TARGETARCH
ENV container docker
LABEL maintainer="tier940"

RUN [ ! -f /usr/sbin/init ] \
    && dnf install -y epel-release tzdata git tar unzip systemd > /dev/null \
    && dnf install -y ansible > /dev/null \
    && yum clean all -y > /dev/null \
    && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
    && (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
        rm -f /lib/systemd/system/multi-user.target.wants/*; \
        rm -f /etc/systemd/system/*.wants/*; \
        rm -f /lib/systemd/system/local-fs.target.wants/*; \
        rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
        rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
        rm -f /lib/systemd/system/basic.target.wants/*; \
        rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /root/work
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
