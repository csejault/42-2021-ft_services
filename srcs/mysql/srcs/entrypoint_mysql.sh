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

WP_DB_NAME=wp_db
WP_DB_USER=wp_adm
PMA_DB_NAME=phpmyadmin
PMA_DB_USER=pma
WP_DB_USER_PASSWORD_HASHED=*0C61DA4C645875C43890D1F29DF8710DADC610DA
PMA_DB_USER_PASSWORD_HASHED=*A51BB7F8CC7E57DC1651A55F5BBC7AF750320054
#WP_DB_USER_PASSWORD_CLEAR='Le mdp de mysql est ceci!'
#PMA_DB_USER_PASSWORD_CLEAR='Le mdp de pma est ceci!'
DB_HOST=localhost
WP_HOST=$ENV_WP_HOST
PMA_HOST=$ENV_PMA_HOST

print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}

echo -e "STARTING MYSQL"
rc-service mariadb start
#service mysql start>>/dev/null && print_success || print_failed


echo -e "CREATE DB [${CYAN}${WP_DB_NAME}${NC}]"
echo "CREATE DATABASE ${WP_DB_NAME};" |mysql -u root && print_success || print_failed
echo -e "CREATE DB [${CYAN}${PMA_DB_NAME}${NC}]"
echo "CREATE DATABASE ${PMA_DB_NAME};" |mysql -u root && print_success || print_failed

echo -e "CREATE USER [${CYAN}${WP_DB_USER}${NC}] WITH HASHED PASSWORD [${CYAN}${WP_DB_USER_PASSWORD_HASHED}${NC}]"
echo "CREATE USER '${WP_DB_USER}'@'${DB_HOST}' IDENTIFIED BY PASSWORD '${WP_DB_USER_PASSWORD_HASHED}';" | mysql -u root && print_success || print_failed
echo -e "CREATE USER [${CYAN}${PMA_DB_USER}${NC}] WITH HASHED PASSWORD [${CYAN}${PMA_DB_USER_PASSWORD_HASHED}${NC}]"
echo "CREATE USER '${PMA_DB_USER}'@'${DB_HOST}' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD_HASHED}';" | mysql -u root && print_success || print_failed

#echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${WP_DB_USER}${NC}] ON [${CYAN}${WP_DB_NAME}${NC}] FOR [${CYAN}${DB_HOST}${NC}]"
#echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'${DB_HOST}'  WITH GRANT OPTION;"|mysql -u root && print_success || print_failed

echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${WP_DB_USER}${NC}] ON [${CYAN}${WP_DB_NAME}${NC}] FOR [${CYAN}${WP_HOST}${NC}]"
echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'${WP_HOST}' IDENTIFIED BY PASSWORD '${WP_DB_USER_PASSWORD_HASHED}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed
echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${PMA_DB_USER}${NC}] ON [${CYAN}${WP_DB_NAME}${NC}] FOR [${CYAN}${PMA_HOST}${NC}]"
echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'${PMA_HOST}' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD_HASHED}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed

echo -e "GRANT ALL PRIVILEGES TO [${CYAN}${PMA_DB_USER}${NC}] ON [${CYAN}${PMA_DB_NAME}${NC}] FOR [${CYAN}${PMA_HOST}${NC}]"
echo "GRANT ALL ON ${PMA_DB_NAME}.* TO '${PMA_DB_USER}'@'${PMA_HOST}' IDENTIFIED BY PASSWORD '${PMA_DB_USER_PASSWORD_HASHED}' WITH GRANT OPTION;"|mysql -u root && print_success || print_failed

echo -e "FLUSH PRIVILEGES"
echo "FLUSH PRIVILEGES;"|mysql -u root && print_success || print_failed

#echo -e "IMPORT SQL DB ON [${CYAN}${WP_DB_NAME}${NC}]"
#mysql  wp_db -u root < ./wp_db.sql && print_success || print_failed
rc-service mariadb stop
ip a|grep inet
mariadbd-safe

exit 0
