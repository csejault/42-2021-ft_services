#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check nginx
wget --no-check-certificate -O - 127.0.0.1 || exit $?

exit 0
