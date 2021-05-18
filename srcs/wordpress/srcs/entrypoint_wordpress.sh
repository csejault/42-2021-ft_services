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
#hostname="wordpress-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"
hostname="wordpress"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
./telegraf.sh && print_success || print_failed

echo -e "${YELLOW}Applying conf with environement var${NC}"
sed -i "s/ENV_WORDPRESS_MYSQL_DB/$ENV_WORDPRESS_MYSQL_DB/g" /var/www/wordpress/wp-config.php \
	&& sed -i "s/'DB_USER', 'ENV_WORDPRESS_MYSQL_USR/'DB_USER', '$ENV_WORDPRESS_MYSQL_USR/" /var/www/wordpress/wp-config.php \
	&& sed -i "s/ENV_WORDPRESS_MYSQL_USR_PWD/$ENV_WORDPRESS_MYSQL_USR_PWD/g" /var/www/wordpress/wp-config.php \
	&& sed -i "s/ENV_MYSQL_HOST/$ENV_MYSQL_HOST/g" /var/www/wordpress/wp-config.php \
	&& print_success || print_failed

echo -e "${YELLOW}Launching install if mysql responding${NC}"
for (( i=1;i<=60;i++ )) do
	echo -e "${YELLOW}Wait mariadb's answer --> $i/60${NC}"
	echo "exit"|mysql -h $ENV_MYSQL_HOST -u $ENV_WORDPRESS_MYSQL_USR --password="$ENV_WORDPRESS_MYSQL_USR_PWD"
	if [[ 0 -eq $? ]]
	then
		wp core install --path="/var/www/wordpress" --url="$ENV_MINIKUBE_HOST:5050"  --title="csetjault's ft_services" --admin_user="$ENV_WORDPRESS_SITE_ADM" --admin_password="$ENV_WORDPRESS_SITE_ADM_PWD" --admin_email="clement.sejault@outlook.com"&& print_success || print_failed
		break
	fi
	sleep 1
done
if [[ i -eq 61 ]]
then
	print_failed
fi

echo -e "${YELLOW}Creating users if not exit${NC}"
wp user list --path=/var/www/wordpress |grep jean
if [[ 0 -eq $? ]]
then
	print_success
else 
	wp user create jean jean@peux.plus --path=/var/www/wordpress --user_pass="jean" && print_success || print_failed
fi
wp user list --path=/var/www/wordpress |grep chris
if [[ 0 -eq $? ]]
then
	print_success
else 
	wp user create chris chris@mende.pneu --path=/var/www/wordpress --user_pass="chris" && print_success || print_failed
fi


echo -e "${YELLOW}Server IP${NC}"
ifconfig|grep inet|grep -v 127.0.0.1

echo -e "${YELLOW}Starting background php${NC}"
php-fpm7 && print_success || print_failed

echo -e "${YELLOW}Starting nginx${NC}"
nginx && print_success || print_failed

exit 0



