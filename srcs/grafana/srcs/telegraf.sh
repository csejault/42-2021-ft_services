#!/bin/sh
telegraf_config_file="/etc/telegraf.conf"
sed -i "s/ENV_TELEGRAF_INFLUXDB_NAME/$ENV_TELEGRAF_INFLUXDB_NAME/g" $telegraf_config_file || exit 1
sed -i "s/ENV_INFLUXDB_HOST/$ENV_INFLUXDB_HOST/g" $telegraf_config_file|| exit 1
sed -i "s/ENV_TELEGRAF_INFLUXDB_USR_PWD/$ENV_TELEGRAF_INFLUXDB_USR_PWD/g" $telegraf_config_file|| exit 1
sed -i "s/ENV_TELEGRAF_INFLUXDB_USR/$ENV_TELEGRAF_INFLUXDB_USR/g" $telegraf_config_file|| exit 1
(telegraf --config $telegraf_config_file &) || exit 1
exit 0
