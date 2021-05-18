FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		21/tcp
EXPOSE		50000

ADD			./srcs .

ENV			ENV_TELEGRAF_INFLUXDB_NAME="telegraf_db" \
			ENV_TELEGRAF_INFLUXDB_USR="telegraf_usr" \
			ENV_TELEGRAF_INFLUXDB_USR_PWD="Le mdp de telegraf est ceci!" \
			ENV_INFLUXDB_HOST="172.17.0.2" \
			ENV_MINIKUBE_HOST="10.13.4.22" \
			ENV_FTPS_USR="ftp_user" \
			ENV_FTPS_USR_PWD="password"

RUN         echo -e "https://dl-cdn.alpinelinux.org/alpine/v3.13/main/\nhttps://dl-cdn.alpinelinux.org/alpine/v3.13/community/\n" >> /etc/apk/repositories \
			&& apk update && apk add --no-cache \
			openssl \
			lftp \
			vsftpd \
			telegraf \
			&& mv telegraf.conf /etc/ \
			&& mv vsftpd.conf /etc/vsftpd/ \
			&& mv ftps_cert.pem /etc/ssl/certs/ftps_cert.pem \
			&& mv ftps_key.pem /etc/ssl/private/ftps_key.pem \
			&& chmod u+x entrypoint_ftps.sh \
			&& echo "set ssl:verify-certificate no" >> ~/.lftprc\
			&& echo "set net:max-retries 1" >> ~/.lftprc

CMD			["./entrypoint_ftps.sh"]
