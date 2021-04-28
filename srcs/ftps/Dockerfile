FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		21/tcp
EXPOSE		50000

ADD			./srcs .

ENV			ENV_MINIKUBE_HOST="10.11.10.22"
ENV			ENV_FTPS_USR="ftp_user"
ENV			ENV_FTPS_USR_PWD="password"

RUN			apk update && apk add --no-cache \
			openrc \
			openssl \
			vsftpd \
			&& openrc \
			&& touch /run/openrc/softlevel \
			&& mv vsftpd.conf /etc/vsftpd/ \
			&& mv ftps_cert.pem /etc/ssl/certs/ftps_cert.pem \
			&& mv ftps_key.pem /etc/ssl/private/ftps_key.pem \
			&& chmod u+x entrypoint_ftps.sh

CMD			["./entrypoint_ftps.sh"]
