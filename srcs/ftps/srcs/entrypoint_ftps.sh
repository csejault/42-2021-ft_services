#!/bin/sh

sed -i "s/ENV_MINIKUBE_HOST/$ENV_MINIKUBE_HOST/g" /etc/vsftpd/vsftpd.conf
rc-service vsftpd start
