#!/bin/sh

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


TELEGRAF_DB_NAME="$ENV_TELEGRAF_INFLUXDB_NAME"
TELEGRAF_DB_USER="$ENV_TELEGRAF_INFLUXDB_USR"
TELEGRAF_DB_USER_PWD="$ENV_TELEGRAF_INFLUXDB_USR_PWD"


print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}


echo -e "STARTING INFLUX"
influxd &

sleep 1

echo -e "CREATE DB [${CYAN}${TELEGRAF_DB_NAME}${NC}]"
(influx -execute "CREATE DATABASE $TELEGRAF_DB_NAME")&& print_success || print_failed

echo -e "CREATE USER [${CYAN}${TELEGRAF_DB_USER}${NC}]WITH PASSWORD [${CYAN}${TELEGRAF_DB_USER_PWD}${NC}]"
(influx -execute "CREATE USER $TELEGRAF_DB_USER WITH PASSWORD '$TELEGRAF_DB_USER_PWD'" )&& print_success || print_failed

echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${TELEGRAF_DB_USER}${NC}] ON [${CYAN}${TELEGRAF_DB_NAME}${NC}]"
(influx -execute "GRANT ALL ON $TELEGRAF_DB_NAME TO $TELEGRAF_DB_USER") && print_success || print_failed

influx -execute "CREATE RETENTION POLICY "a_year" ON "$TELEGRAF_DB_NAME" DURATION 52w REPLICATION 1 DEFAULT"
kill -15 $(ps|grep -e influxd |grep -v grep|awk '{print $1}')
influxd
exit 0
