# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/05/18 13:59:10 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#PhP EXTENSION NEEDED BY WORDPRESS :
#https://make.wordpress.org/hosting/handbook/handbook/server-environment/
FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		5050/tcp

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_MYSQL_HOST="172.17.0.4" \
			ENV_WORDPRESS_MYSQL_DB="wp_db" \
			ENV_WORDPRESS_MYSQL_USR="wp_adm" \
			ENV_WORDPRESS_MYSQL_USR_PWD="Le mdp de mysql est ceci!" \
			ENV_WORDPRESS_SITE_ADM="csejault_adm" \
			ENV_WORDPRESS_SITE_ADM_PWD="Le mdp de wordpress est ceci!" \
			ENV_MINIKUBE_HOST="127.0.0.1"

CMD			["./entrypoint_wordpress.sh"]

ADD			./srcs .

RUN         echo -e "https://dl-cdn.alpinelinux.org/alpine/v3.13/main/\nhttps://dl-cdn.alpinelinux.org/alpine/v3.13/community/\n" >> /etc/apk/repositories \
			&& apk update && apk add --no-cache \
			mysql-client\
			nginx \
			bash \
			php7-session\
			php7-ctype\
			php7\
			php7-common\
			php7-json\
			php7-fpm\
			php7-xml\
			php7-mbstring\
			php7-cgi\
			php7-mysqli\
			php7-mysqlnd\
			php7-curl\
			php7-dom\
			php7-exif\
			php7-fileinfo\
			php7-sodium\
			php7-openssl\
			php7-zip\
			php7-gd\
			php7-iconv\
			php7-simplexml\
			php7-xmlreader \
			php7-phar \
			telegraf \
			&& mv telegraf.conf /etc/ \
			&& chmod u+x ./entrypoint_wordpress.sh \
			&& mkdir -p -m 755 /run/nginx/ \
			&& chown nginx:nginx /run/nginx \
			&& mkdir -p /var/www \
			&& tar xvz -f wordpress-5.7-fr_FR.tar.gz -C /var/www \
			&& mv wp-config.php /var/www/wordpress/ \
			&& chown -R nginx:nginx /var/www/ \
			&& mv wordpress.conf /etc/nginx/conf.d/ \
			&& rm /etc/nginx/conf.d/default.conf \
			&& rm wordpress-5.7-fr_FR.tar.gz \
			&& mv wordpress_cert.pem /etc/ssl/certs/ \
			&& mv wordpress_key.pem /etc/ssl/private/ \
			&& mv wp-cli.phar /usr/local/bin/wp \
			&& echo "daemon off;" >> /etc/nginx/nginx.conf \
			&& nginx -t

			#&& echo "daemon off;" >> /etc/nginx/nginx.conf \
