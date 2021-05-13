# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/14 15:16:36 by csejault          #+#    #+#              #
#    Updated: 2021/05/13 16:35:22 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#NGINX
#RM DEFAULT

FROM		alpine

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE 		80/tcp
EXPOSE 		443/tcp

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_MINIKUBE_HOST="127.0.0.1" \
			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!"

CMD			["./entrypoint_nginx.sh"]

COPY		srcs .

RUN			apk update \
			&& apk add --no-cache \
			bash \
			nginx\
			openssl \
			telegraf \
			&& mkdir -p -m 755 /run/nginx/ \
			&& chown nginx:nginx /run/nginx \
			&& echo "daemon off;" >> /etc/nginx/nginx.conf \
			&& mv csejault.conf /etc/nginx/conf.d/ \
			&& rm /etc/nginx/conf.d/default.conf \
			&& mkdir -p /var/www/csejault \
			&& mv csejault.html /var/www/csejault/index.html \
			&& mv nginx_cert.pem /etc/ssl/certs/ \
			&& mv nginx_key.pem /etc/ssl/private/ \
			&& mv telegraf.conf /etc/
