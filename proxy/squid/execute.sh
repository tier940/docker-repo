#!/bin/sh

chown squid:squid /dev/stdout
chown squid:squid /var/run/squid
/usr/sbin/squid -N -f /etc/squid/squid.conf
