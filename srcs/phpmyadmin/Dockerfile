# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/15 17:47:31 by csejault          #+#    #+#              #
#    Updated: 2021/04/21 15:25:58 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#https://docs.phpmyadmin.net/en/latest/require.html

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE 		5000/tcp

ENV			ENV_MYSQL_HOST="172.17.0.2"

ADD			./srcs .



RUN			apk update && apk add --no-cache \
			openrc \
			php7\
			php7-common\
			php7-fpm\
			php7-session\
			php7-ctype\
			php7-json\
			php7-mbstring\
			php7-zip\
			php7-gd\
			php7-openssl\
			libxml2\
			php7-xml\
			php7-mysqli\
			php7-iconv\
			nginx \
			&& chmod u+x ./entrypoint_phpmyadmin.sh \
			&& mkdir -p -m 755 /run/nginx/ \
			&& chown nginx:nginx /run/nginx \
			&& mkdir -p /var/www \
			&& tar xvz -f phpMyAdmin-5.1.0-all-languages.tar.gz -C /var/www \
			&& mv /var/www/phpMyAdmin-5.1.0-all-languages /var/www/phpmyadmin \
			&& mv config.inc.php /var/www/phpmyadmin/ \
			&& rm ./phpMyAdmin-5.1.0-all-languages.tar.gz \
			&& mkdir -p /var/www/phpmyadmin/tmp \
			&& chmod a+w /var/www/phpmyadmin/tmp \
			&& chown -R nginx:nginx /var/www/ \
			&& mv phpmyadmin.conf /etc/nginx/conf.d/ \
			&& rm /etc/nginx/conf.d/default.conf \
			&& nginx -t
RUN			openrc && touch /run/openrc/softlevel

CMD			["./entrypoint_phpmyadmin.sh"]
