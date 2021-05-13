#!/bin/sh
#hostname="grafana-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"
hostname="grafana"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
./telegraf.sh
#curlftpfs $ENV_FTPS_HOST /usr/share/grafana/conf/provisioning/dashboards/ftps -o ssl,no_verify_peer,no_verify_hostname,user=ftp_user:password
grafana-server --homepath "/usr/share/grafana"
