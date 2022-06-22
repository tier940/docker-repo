#!/usr/bin/env bash
LSDIR='/usr/local/lsws'

# Run the Server
/usr/local/lsws/bin/lswsctrl start
$@
while true; do
  if ! /usr/local/lsws/bin/lswsctrl status | grep 'litespeed is running with PID *' > /dev/null; then
    break
  fi
  sleep 60
done
