# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/14 15:16:36 by csejault          #+#    #+#              #
#    Updated: 2021/04/20 15:30:25 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#NGINX
#RM DEFAULT

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE 		80/tcp
EXPOSE 		443/tcp

ENV			ENV_WORDPRESS_HOST="127.0.0.1"

CMD			["./entrypoint_nginx.sh"]

COPY		srcs .

RUN			apk update \
			&& apk add nginx --no-cache \
			&& mkdir -p -m 755 /run/nginx/ \
			&& chown nginx:nginx /run/nginx \
			&& echo "daemon off;" >> /etc/nginx/nginx.conf \
			&& nginx -t \
			&& mv csejault.conf /etc/nginx/conf.d/ \
			&& rm /etc/nginx/conf.d/default.conf \
			&& mkdir -p /var/www/csejault \
			&& mv csejault.html /var/www/csejault/index.html
