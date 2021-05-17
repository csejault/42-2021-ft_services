# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/05/17 13:38:20 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#MARIADB
#USE SSH insted of 3306?

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		3306

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_MYSQL_HOST="172.17.0.3" \
			ENV_MINIKUBE_HOST="127.0.0.1" \
			ENV_PHPMYADMIN_HOST="172.17.0.5" \
			ENV_WORDPRESS_HOST="172.17.0.6" \
			ENV_WORDPRESS_MYSQL_DB="wp_db" \
			ENV_WORDPRESS_SITE_ADM="csejault_adm" \
			ENV_WORDPRESS_SITE_ADM_PWD="Le mdp de wordpress est ceci!" \
			ENV_WORDPRESS_MYSQL_USR="wp_adm" \
			ENV_WORDPRESS_MYSQL_USR_PWD="Le mdp de mysql est ceci!" \
			ENV_PHPMYADMIN_MYSQL_USR="pma" \
			ENV_PHPMYADMIN_MYSQL_USR_PWD="Le mdp de pma est ceci!"
CMD			["./entrypoint_mysql.sh"]

ADD			./srcs .

RUN         echo -e "https://dl-cdn.alpinelinux.org/alpine/v3.13/main/\nhttps://dl-cdn.alpinelinux.org/alpine/v3.13/community/\n" >> /etc/apk/repositories \
			&& apk update \
			&& apk add --no-cache \
			bash \
			mariadb\
			mariadb-common\
			mariadb-client\
			openrc \
			telegraf \
			&& mv telegraf.conf /etc/ \
			&& mv mariadb-server.cnf /etc/my.cnf.d/


#BACKUP SQL
#ADD			./srcs/backup/wp_db.sql .


