# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/04/21 14:50:40 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#PhP EXTENSION NEEDED BY WORDPRESS :
#https://make.wordpress.org/hosting/handbook/handbook/server-environment/
FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		5050/tcp

ENV			ENV_MYSQL_HOST="172.17.0.2"
ENV			ENV_WORDPRESS_MYSQL_DB="wp_db"
ENV			ENV_WORDPRESS_MYSQL_USR="wp_adm"
ENV			ENV_WORDPRESS_MYSQL_USR_PWD="Le mdp de mysql est ceci!"

CMD			["./entrypoint_wordpress.sh"]

ADD			./srcs .

RUN			apk update && apk add --no-cache \
			openrc \
			php7\
			php7-common\
			php7-json\
			php7-fpm\
			php7-xml\
			php7-mbstring\
			php7-cgi\
			php7-mysqli\
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
			nginx \
			&& chmod u+x ./entrypoint_wordpress.sh \
			&& mkdir -p -m 755 /run/nginx/ \
			&& chown nginx:nginx /run/nginx \
			&& mv wordpress.conf /etc/nginx/conf.d/ \
			&& rm /etc/nginx/conf.d/default.conf \
			&& mkdir -p /var/www \
			&& tar xvz -f wordpress-5.7-fr_FR.tar.gz -C /var/www \
			&& rm wordpress-5.7-fr_FR.tar.gz \
			&& mv wp-config.php /var/www/wordpress/ \
			&& chown -R nginx:nginx /var/www/ \
			&& nginx -t 
RUN			openrc && touch /run/openrc/softlevel

			#&& echo "daemon off;" >> /etc/nginx/nginx.conf \
