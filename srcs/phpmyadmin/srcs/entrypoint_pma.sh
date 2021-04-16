ip a|grep inet

sed -i "s/ENV_DB_HOST/$ENV_DB_HOST/g" /var/www/phpmyadmin/config.inc.php
php8 -S 0.0.0.0:5000 -t /var/www/phpmyadmin/
