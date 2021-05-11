#!/bin/sh

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

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

#SSL GENERATION
# openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj '/CN=nginx.csejault'
echo -e "${YELLOW}Starting Telegraf${NC}"
./telegraf.sh && print_success || print_failed
sed -i "s/ENV_MINIKUBE_HOST/$ENV_MINIKUBE_HOST/g" /etc/nginx/conf.d/csejault.conf
echo -e "${YELLOW}Starting NGINX${NC}"
nginx -t && nginx && print_success || print_failed
exit 0
