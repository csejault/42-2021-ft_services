# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/08 15:15:51 by csejault          #+#    #+#              #
#    Updated: 2021/05/13 18:23:37 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#INFLUXDB

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		8086

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="127.0.0.1"

ADD			./srcs/ .

RUN         echo -e "https://dl-cdn.alpinelinux.org/alpine/v3.13/main/\nhttps://dl-cdn.alpinelinux.org/alpine/v3.13/community/\n" >> /etc/apk/repositories \
			&& apk update \
			&& apk add --no-cache \
			bash \
			influxdb \
			telegraf \
			&& mv telegraf.conf /etc/
			 

CMD			["./entrypoint_infkuxdb.sh"]
#CMD			["./entrypoint_infkuxdb.sh"]

