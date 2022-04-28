FROM rockylinux/rockylinux:8

ENV TZ=Asia/Tokyo


RUN dnf update -y && \
    dnf install https://www.ngtech.co.il/repo/centos/8/beta/x86_64/squid-5.4-1.el8.x86_64.rpm -y && \
    dnf install https://www.ngtech.co.il/repo/centos/8/beta/x86_64/squid-helpers-5.4-1.el8.x86_64.rpm -y && \
    dnf clean all -y && \
    dnf autoremove -y

COPY squid.conf /etc/squid/
COPY lxc-whitelist /etc/squid/whitelist
#COPY mycert.pem /etc/squid/mycert.pem
COPY execute.sh /execute.sh

RUN touch /var/run/squid
# RUN /usr/lib64/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 20MB

EXPOSE 3128
USER squid
CMD ["/execute.sh"]
