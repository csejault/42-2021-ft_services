# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/08 15:15:51 by csejault          #+#    #+#              #
#    Updated: 2021/05/08 17:26:33 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#INFLUXDB

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db"
ENV			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr"
ENV			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!"
ENV			ENV_MYSQL_HOST="172.17.0.2"
ENV			ENV_MINIKUBE_HOST="127.0.0.1"
ENV			ENV_PHPMYADMIN_HOST="172.17.0.3"
ENV			ENV_WORDPRESS_HOST="172.17.0.4"
ENV			ENV_WORDPRESS_MYSQL_DB="wp_db"
ENV			ENV_WORDPRESS_SITE_ADM="csejault_adm"
ENV			ENV_WORDPRESS_SITE_ADM_PWD="Le mdp de wordpress est ceci!"
ENV			ENV_WORDPRESS_MYSQL_USR="wp_adm"
ENV			ENV_WORDPRESS_MYSQL_USR_PWD="Le mdp de mysql est ceci!"
ENV			ENV_PHPMYADMIN_MYSQL_USR="pma"
ENV			ENV_PHPMYADMIN_MYSQL_USR_PWD="Le mdp de pma est ceci!"

ADD			./srcs/ .

RUN			apk update \
			&& apk add --no-cache \
			influxdb \
			&& tar xvf telegraf-1.18.2_linux_amd64.tar.gz --strip 2 -C /

CMD			["/bin/sh"]
#CMD			["./entrypoint_infkuxdb.sh"]

