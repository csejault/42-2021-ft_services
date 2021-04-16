# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/30 12:08:38 by csejault          #+#    #+#              #
#    Updated: 2021/04/16 16:47:01 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#MARIADB
#USE SSH insted of 3306?

FROM		alpine:3.13

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		3306

ENV			ENV_PMA_HOST=172.17.0.3
ENV			ENV_WP_HOST=172.17.0.4

CMD			["./entrypoint_mysql.sh"]

ADD			./srcs .

RUN			apk update \
			&& apk add --no-cache \
			mariadb=10.5.8-r0 \
			mariadb-common=10.5.8-r0 \
			mariadb-client=10.5.8-r0 \
			openrc \
			&& openrc \
			&& touch /run/openrc/softlevel \
			&& rc-service mariadb setup \
			&& mv mariadb-server.cnf /etc/my.cnf.d/


#BACKUP SQL
#ADD			./srcs/backup/wp_db.sql .


