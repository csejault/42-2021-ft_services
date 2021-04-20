# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/04/16 16:38:56 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#PhP EXTENSION NEEDED BY WORDPRESS :
#https://make.wordpress.org/hosting/handbook/handbook/server-environment/
FROM		alpine:3.13

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		5050

ENV			ENV_DB_HOST=172.17.0.2

ENTRYPOINT	["/bin/sh"]

RUN			apk update && apk add --no-cache \
			php8=8.0.2-r0 \
			php8-common=8.0.2-r0 \
			php8-fpm=8.0.2-r0 \
			php8-xml=8.0.2-r0 \
			php8-mbstring=8.0.2-r0 \
			php8-cgi=8.0.2-r0 \
			php8-mysqli=8.0.2-r0 \
			php8-curl=8.0.2-r0 \
			php8-dom=8.0.2-r0 \
			php8-exif=8.0.2-r0 \
			php8-fileinfo=8.0.2-r0 \
			php8-sodium=8.0.2-r0 \
			php8-openssl=8.0.2-r0 \
			php8-zip=8.0.2-r0 \
			php8-gd=8.0.2-r0 \
			php8-iconv=8.0.2-r0 \
			php8-simplexml=8.0.2-r0 \
			php8-xmlreader=8.0.2-r0 

ADD			./srcs .
RUN			mkdir -p /var/www && tar xvz -f wordpress-5.7-fr_FR.tar.gz -C /var/www \
			&& rm wordpress-5.7-fr_FR.tar.gz && mv wp-config.php /var/www/wordpress/
