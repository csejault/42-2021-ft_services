#GRAFANA

FROM		alpine

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		3000

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_PHPMYADMIN_HOST="172.17.0.3"

ADD			./srcs/ .

RUN			apk update \
			&& apk add --no-cache \
			grafana \
			telegraf \
			&& mv grafana.ini /etc \
			&& mv telegraf.conf /etc/

CMD			["./entrypoint_grafana.sh"]
#CMD			["./entrypoint_infkuxdb.sh"]

