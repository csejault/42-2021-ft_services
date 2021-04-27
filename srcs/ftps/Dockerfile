FROM		alpine:3.12

LABEL		maintainer="csejault"

WORKDIR		/root/

EXPOSE		21/tcp
EXPOSE		50000

ADD			./srcs .

ENV			ENV_MINIKUBE_HOST="10.11.10.22"
RUN			apk update && apk add --no-cache \
			openrc \
			openssl \
			vsftpd \
			&& openrc \
			&& touch /run/openrc/softlevel \
			&& mv vsftpd.conf /etc/vsftpd/ \
			&& mv ftps_cert.pem /etc/ssl/certs/ftps_cert.pem \
			&& mv ftps_key.pem /etc/ssl/private/ftps_key.pem \
			&& adduser -h /home/test -s /sbin/nologin -D test \
			&& passwd -d 'test' test \
			&& echo "test">/etc/vsftpd.chroot_list \
			&& chmod u+x entrypoint_ftps.sh

CMD			["./entrypoint_ftps.sh"]
