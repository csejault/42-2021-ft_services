# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/15 17:47:31 by csejault          #+#    #+#              #
#    Updated: 2021/04/16 17:06:19 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#https://docs.phpmyadmin.net/en/latest/require.html

FROM		alpine:3.13

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE 		5000/tcp

ENV			ENV_DB_HOST=172.17.0.2

CMD			["./entrypoint_pma.sh"]

RUN			apk update && apk add --no-cache \
			php8=8.0.2-r0 \
			php8-fpm=8.0.2-r0 \
			php8-iconv=8.0.2-r0 \
			php8-xml=8.0.2-r0 \
			php8-session=8.0.2-r0 \
			php8-common=8.0.2-r0 \
			php8-ctype=8.0.2-r0 \
			php8-mbstring=8.0.2-r0 \
			php8-mysqli=8.0.2-r0 \
			php8-zip=8.0.2-r0 \
			php8-gd=8.0.2-r0 \
			php8-openssl=8.0.2-r0 

ADD			srcs .
RUN			mkdir -p /var/www \
			&& tar xvz -f phpMyAdmin-5.1.0-all-languages.tar.gz -C /var/www \
			&& mv /var/www/phpMyAdmin-5.1.0-all-languages /var/www/phpmyadmin \
			&& mv config.inc.php /var/www/phpmyadmin/ \
			&& rm ./phpMyAdmin-5.1.0-all-languages.tar.gz
