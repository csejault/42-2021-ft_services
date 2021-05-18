#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}

echo -e "${YELLOW}Starting Telegraf${NC}"
#hostname="ftps-$(ifconfig|grep inet|grep -v 127.0.0.1|sed -E s/"inet addr:"//|sed -E s/B.*$//|awk '{print $1}')"

tail -f /var/log/vsftpd.log &
hostname="ftps"
sed -i "s/hostname = \"\"/hostname = \"${hostname}\"/g" /etc/telegraf.conf
./telegraf.sh && print_success || print_failed

echo -e "${YELLOW}Creating ftps user${NC}"
adduser -h /home/ftp -s /sbin/nologin -D $ENV_FTPS_USR && print_success || print_failed
echo "up" > /home/ftp/.DoNotDelete_ForHealth

echo -e "${YELLOW}Creating password ftps user${NC}"
(echo "$ENV_FTPS_USR_PWD";echo "$ENV_FTPS_USR_PWD")|passwd $ENV_FTPS_USR  && print_success || print_failed

echo -e "${YELLOW}Applying conf with env var${NC}"
sed -i "s/ENV_MINIKUBE_HOST/$ENV_MINIKUBE_HOST/g" /etc/vsftpd/vsftpd.conf && print_success || print_failed

echo -e "${YELLOW}Creating log file${NC}"
touch /var/log/vsftpd.log && print_success || print_failed

echo -e "${YELLOW}Launching ftps${NC}"
vsftpd /etc/vsftpd/vsftpd.conf && print_success || print_failed
sleep 200

