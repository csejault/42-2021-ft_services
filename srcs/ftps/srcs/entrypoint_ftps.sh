#!/bin/sh

adduser -h /home/ftp -s /sbin/nologin -D $ENV_FTPS_USR
(echo "$ENV_FTPS_USR_PWD";echo "$ENV_FTPS_USR_PWD")|passwd $ENV_FTPS_USR
sed -i "s/ENV_MINIKUBE_HOST/$ENV_MINIKUBE_HOST/g" /etc/vsftpd/vsftpd.conf
rc-service vsftpd start
touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log
