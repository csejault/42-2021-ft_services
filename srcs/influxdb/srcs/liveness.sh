#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check influxdb 
echo -n "show databases"|influx || exit $?

exit 0
