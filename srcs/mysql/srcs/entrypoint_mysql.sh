#!/bin/bash

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

WP_DB_NAME=wp_db
WP_DB_USER="$ENV_WORDPRESS_MYSQL_USR"
PMA_DB_NAME=phpmyadmin
PMA_DB_USER="$ENV_PHPMYADMIN_MYSQL_USR"
DB_HOST=localhost
#WP_HOST="$ENV_WORDPRESS_HOST"
WP_HOST="%"
PMA_HOST="$ENV_PHPMYADMIN_HOST"

print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}

#hostname="mysql-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"
hostname="mysql"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
echo -e "STARTING TELEFRAF"
./telegraf.sh && print_success || print_failed

mysql_install_db --user=mysql --datadir="/var/lib/mysql"

echo -e "STARTING MYSQL"
(mysqld_safe --datadir="/var/lib/mysql" &) && print_success || print_failed

for (( i=1;i<=60;i++ )) do
	echo -e "${YELLOW}Wait for mariadb do start --> $i/60${NC}"
	mysqladmin status 2>/dev/null
	if [[ 0 -eq $? ]]
	then
		print_success
		break
	fi
	sleep 1
done
if [[ i -eq 61 ]]
then
	print_failed
fi

#service mysql start>>/dev/null && print_success || print_failed
WP_DB_USER_PASSWORD=$( echo "SELECT PASSWORD('${ENV_WORDPRESS_MYSQL_USR_PWD}');"|mysql -u root|grep '*' )
PMA_DB_USER_PASSWORD=$( echo "SELECT PASSWORD('${ENV_PHPMYADMIN_MYSQL_USR_PWD}');"|mysql -u root|grep '*' )

echo -e "CREATE DB [${CYAN}${WP_DB_NAME}${NC}]"
echo "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};" |mysql -u root && print_success || print_failed
echo -e "CREATE DB [${CYAN}${PMA_DB_NAME}${NC}]"
echo "CREATE DATABASE IF NOT EXISTS ${PMA_DB_NAME};" |mysql -u root && print_success || print_failed

echo -e "CREATE USER [${CYAN}${WP_DB_USER}${NC}]WITH HASHED PASSWORD [${CYAN}${WP_DB_USER_PASSWORD}${NC}]"
echo "CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'${DB_HOST}' IDENTIFIED BY PASSWORD '${WP_DB_USER_PASSWORD}';" | mysql -u root && print_success || print_failed

echo -e "CREATE USER [${CYAN}${PMA_DB_USER}${NC}]WITH HASHED PASSWORD [${CYAN}${PMA_DB_USER_PASSWORD}${NC}]"
echo "CREATE USER IF NOT EXISTS '${PMA_DB_USER}'@'${DB_HOST}' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD}';" | mysql -u root && print_success || print_failed

echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${WP_DB_USER}${NC}] ON [${CYAN}${WP_DB_NAME}${NC}] FOR [${CYAN}%${NC}]"
echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%' IDENTIFIED BY PASSWORD '${WP_DB_USER_PASSWORD}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed
echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${PMA_DB_USER}${NC}] ON [${CYAN}${WP_DB_NAME}${NC}] FOR [${CYAN}%${NC}]"
echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${PMA_DB_USER}'@'%' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed

echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${PMA_DB_USER}${NC}] ON [${CYAN}${PMA_DB_NAME}${NC}] FOR [${CYAN}%${NC}]"
echo "GRANT ALL ON ${PMA_DB_NAME}.* TO '${PMA_DB_USER}'@'%' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed

echo -e "FLUSH PRIVILEGES"
echo "FLUSH PRIVILEGES;"|mysql -u root && print_success || print_failed

#sed  -i -E "s+\(1\, \'siteurl\', \'https://[0-9]?[0-9]?[0-9]?\.[0-9]?[0-9]?[0-9]\.[0-9]?[0-9]?[0-9]\.[0-9]?[0-9]?[0-9]+(1, 'siteurl', 'https://$ENV_MINIKUBE_HOST+g" "./wp_db.sql"
#sed  -i -E "s+\(2\, \'home\', \'https://[0-9]?[0-9]?[0-9]?\.[0-9]?[0-9]?[0-9]\.[0-9]?[0-9]?[0-9]\.[0-9]?[0-9]?[0-9]+(2, 'home', 'https://$ENV_MINIKUBE_HOST+g" "./wp_db.sql"
#echo -e "IMPORT SQL DB ON [${CYAN}${WP_DB_NAME}${NC}]"
#mysql  wp_db -u root < ./wp_db.sql && print_success || print_failed
echo "show tables from phpmyadmin;"|mysql|grep pma__table_info &> /dev/nul
if [[ $? -ne 0 ]]
then
	echo -e "CREATE SQL TABLE ON [${CYAN}${PMA_DB_NAME}${NC}]"
	mysql phpmyadmin -u root < ./phpmyadmin.sql && print_success || print_failed
fi

ip a|grep inet
#rc-service mariadb start
echo -e "${GREEN}CONFIGURATION OK RESTARTING${NC}"
mysqladmin shutdown && print_success || print_failed
mysqld_safe --datadir="/var/lib/mysql"  && print_success || print_failed
exit 1
