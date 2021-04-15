# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/14 15:16:36 by csejault          #+#    #+#              #
#    Updated: 2021/04/15 17:37:39 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#NGINX

FROM		alpine:3.13

ENV ENV_REDIR_WP_HOST=127.0.0.1

LABEL		maintainer="csejault"

WORKDIR		/root/

##NETWORK
EXPOSE 		80/tcp
EXPOSE 		443/tcp

CMD ["./entrypoint_nginx.sh"]

COPY			srcs .

##INSTALL
RUN				apk update && \
				apk add nginx=1.18.0-r13 \
				--no-cache \
				&& mkdir -p -m 755 /run/nginx/ \
				&& chown nginx:nginx /run/nginx \
				&& echo "daemon off;" >> /etc/nginx/nginx.conf \
				&& nginx -t \
				&& mv csejault.conf /etc/nginx/http.d \
				&& mkdir /var/www/wordpress \
				&&  echo test>>/var/www/wordpress/index.html


#
##SITES
#RUN			chown -vR www-data:www-data /var/www/*
#
##SCRIPTS
#RUN			mkdir -p ./scripts
#ADD			./srcs/scripts/* ./scripts/
#RUN			chown -vR root:root scripts/
#RUN			chmod -vR 700 scripts/
#
##CONF NGINX
#
##CHECK CONF NGINX
