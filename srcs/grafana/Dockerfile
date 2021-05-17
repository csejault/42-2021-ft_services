#GRAFANA

FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		3000

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_FTPS_HOST="172.17.0.4"

ADD			./srcs/ .

RUN         echo -e "https://dl-cdn.alpinelinux.org/alpine/v3.13/main/\nhttps://dl-cdn.alpinelinux.org/alpine/v3.13/community/\n" >> /etc/apk/repositories \
			&& apk update \
			&& apk add --no-cache \
			grafana \
			telegraf \
			&& apk add -X https://dl-cdn.alpinelinux.org/alpine/edge/testing curlftpfs \
			&& mv grafana.ini /etc \
			&& mv telegraf.conf /etc/ \
			&& mv datasources.yaml /usr/share/grafana/conf/provisioning/datasources/ \
			&& mv provider.yaml /usr/share/grafana/conf/provisioning/dashboards \
			&& mv dashboards/*.json /usr/share/grafana/conf/provisioning/dashboards/
			#&& mkdir /usr/share/grafana/conf/provisioning/dashboards/ftps

CMD			["./entrypoint_grafana.sh"]

