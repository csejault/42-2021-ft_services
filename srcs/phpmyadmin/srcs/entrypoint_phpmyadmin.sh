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
NC='\033[0m' # No Color


print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}

echo -e "${YELLOW}Starting Telegraf${NC}"
#hostname="phpmyadmin-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"
hostname="phpmyadmin"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
./telegraf.sh && print_success || print_failed
echo -e "${YELLOW}Applying conf with environement var${NC}"
sed -i "s/ENV_MYSQL_HOST/$ENV_MYSQL_HOST/g" /var/www/phpmyadmin/config.inc.php && print_success || print_failed

echo -e "${YELLOW}Server IP${NC}"
ifconfig|grep inet|grep -v 127.0.0.1

echo -e "${YELLOW}Starting background php${NC}"
php-fpm7 && print_success || print_failed

echo -e "${YELLOW}Starting nginx${NC}"
nginx && print_success || print_failed

