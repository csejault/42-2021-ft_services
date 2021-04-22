# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/04/22 16:20:25 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#MARIADB
#USE SSH insted of 3306?

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		3306

ENV			ENV_MYSQL_HOST="172.17.0.2"
ENV			ENV_PHPMYADMIN_HOST="172.17.0.3"
ENV			ENV_WORDPRESS_HOST="172.17.0.4"
ENV			ENV_WORDPRESS_MYSQL_DB="wp_db"
ENV			ENV_WORDPRESS_SITE_ADM="csejault_adm"
ENV			ENV_WORDPRESS_SITE_ADM_PWD="Le mdp de wordpress est ceci!"
ENV			ENV_WORDPRESS_MYSQL_USR="wp_adm"
ENV			ENV_WORDPRESS_MYSQL_USR_PWD="Le mdp de mysql est ceci!"
ENV			ENV_PHPMYADMIN_MYSQL_USR="pma"
ENV			ENV_PHPMYADMIN_MYSQL_USR_PWD="Le mdp de pma est ceci!"
CMD			["./entrypoint_mysql.sh"]

ADD			./srcs .

RUN			apk update \
			&& apk add --no-cache \
			mariadb\
			mariadb-common\
			mariadb-client\
			openrc \
			&& openrc \
			&& touch /run/openrc/softlevel \
			&& rc-service mariadb setup \
			&& mv mariadb-server.cnf /etc/my.cnf.d/


#BACKUP SQL
#ADD			./srcs/backup/wp_db.sql .


