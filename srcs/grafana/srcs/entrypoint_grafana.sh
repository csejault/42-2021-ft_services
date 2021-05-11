#!/bin/sh
./telegraf.sh
grafana-server  --homepath "/usr/share/grafana"
