#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check grafana
wget --no-check-certificate -O - http://127.0.0.1:3000 ||exit $?

exit 0
