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

ip a|grep inet

sed -i "s/ENV_WORDPRESS_MYSQL_DB/$ENV_WORDPRESS_MYSQL_DB/g" /var/www/wordpress/wp-config.php
sed -i "s/'DB_USER', 'ENV_WORDPRESS_MYSQL_USR/'DB_USER', '$ENV_WORDPRESS_MYSQL_USR/" /var/www/wordpress/wp-config.php
sed -i "s/ENV_WORDPRESS_MYSQL_USR_PWD/$ENV_WORDPRESS_MYSQL_USR_PWD/g" /var/www/wordpress/wp-config.php
sed -i "s/ENV_MYSQL_HOST/$ENV_MYSQL_HOST/g" /var/www/wordpress/wp-config.php

echo -e "${YELLOW}Starting background NGINX${NC}"
rc-service php-fpm7 restart
rc-service nginx restart
ps
echo -e "${GREEN} === SERVER STARTED === ${NC}"
tail -f /var/log/nginx/access.log /var/log/nginx/error.log

exit 0
