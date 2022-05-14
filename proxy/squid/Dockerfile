FROM rockylinux/rockylinux:8

RUN dnf update -y && \
    dnf install https://www.ngtech.co.il/repo/centos/8/x86_64/squid-5.5-1.el8.x86_64.rpm -y && \
    dnf install https://www.ngtech.co.il/repo/centos/8/x86_64/squid-helpers-5.5-1.el8.x86_64.rpm -y && \
    dnf clean all -y && \
    dnf autoremove -y

COPY squid.conf /etc/squid/
COPY lxc-whitelist /etc/squid/whitelist
#COPY mycert.pem /etc/squid/mycert.pem
RUN touch /var/run/squid \
  && chown squid:squid /var/run/squid \
  && touch /var/run/squid
# RUN /usr/lib64/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 20MB

ENV TZ=Asia/Tokyo

EXPOSE 3128
USER squid
CMD ["/usr/sbin/squid", "-N", "-f", "/etc/squid/squid.conf"]
