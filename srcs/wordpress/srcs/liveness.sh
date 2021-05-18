#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check nginx & php
wget --no-check-certificate -O - https://127.0.0.1:5050 || exit $?

exit 0
