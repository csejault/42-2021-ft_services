#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check mysqld
mysqladmin status || exit $?

exit 0
