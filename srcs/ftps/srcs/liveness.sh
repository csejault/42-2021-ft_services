#!/bin/sh

#check telegraf
ps | grep -e "telegraf --config /etc/telegraf.conf" | grep -v grep || exit $?

#check ftps
echo "cat .DoNotDelete_ForHealth"|lftp -u ftp_user,password -e "set ssl:verify-certificate  no" 127.0.0.1 || exit $?

exit 0
