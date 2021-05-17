#!/bin/sh
#hostname="grafana-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"
hostname="grafana"
datasources_file="/usr/share/grafana/conf/provisioning/datasources/datasources.yaml"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
./telegraf.sh
sed -i "s/ENV_INFLUXDB_HOST/$ENV_INFLUXDB_HOST/g" $datasources_file && print_success || print_failed
sed -i "s/user: ENV_TELEGRAF_INFLUXDB_USR/user: \"$ENV_TELEGRAF_INFLUXDB_USR\"/g" $datasources_file && print_success || print_failed
sed -i "s/ENV_TELEGRAF_INFLUXDB_NAME/\"$ENV_TELEGRAF_INFLUXDB_NAME\"/g" $datasources_file && print_success || print_failed
sed -i "s/password: ENV_TELEGRAF_INFLUXDB_USR_PWD/password: \"$ENV_TELEGRAF_INFLUXDB_USR_PWD\"/g" $datasources_file && print_success || print_failed
#curlftpfs $ENV_FTPS_HOST /usr/share/grafana/conf/provisioning/dashboards/ftps -o ssl,no_verify_peer,no_verify_hostname,user=ftp_user:password
grafana-server --homepath "/usr/share/grafana"
