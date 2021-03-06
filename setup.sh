#!/bin/bash
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
CYAN='\033[0;36m'
NC='\033[0m' # No Color

#BEFORE LAUNCHING
#sudo systemctl disable nginx
#sudo systemctl disable mysql
# service nginx stop  
# service mysql stop 
#sudo usermod -aG docker $USER && newgrp docker

#To Install brew
#rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
#brew install minikube


v_os="42xubuntu"
v_mac_os="42mac"
v_kube_needed_version="1.20.0"

f_42mac()
{
	v_goinfre_path="/goinfre/csejault"
	v_path_setup="/sgoinfre/goinfre/Perso/csejault/ft_services"
}
f_debian()
{
	v_path_setup="/home/csejault/42-2021-ft_services"
}
f_42xubuntu()
{
	v_path_setup="./"
	minikube config set vm-driver docker &>/dev/null
	minikube config set memory 2048 &>/dev/null
	minikube config set cpus 2 &>/dev/null
}

print_success()
{
	echo -e "[${GREEN}SUCCESS${NC}]" 
}

print_failed()
{
	echo -e "[${RED}FAILED${NC}] --> EXIT" 
	exit 1
}

f_check_args()
{
	#
	#	if [[ $1 != "--os="* ]]
	#	then
	#		echo "need the os flag in first position"
	#		return 1
	#	else
	#		v_os=$(echo $1|sed 's/--os=//g')
	#		shift;
	#		echo "OS = $v_os"
	#	fi
	while [[ $# > 0 ]] ;
	do
		arg="$1"
		shift;
		case "$arg" in
			"--os="*)
				v_os=$(echo $arg|sed 's/--os=//g')
				;;
			"kdr")
				f_kube_deployment_reset $1 || print_failed
				shift
				;;
			"dr")
				f_docker_run_detach $1
				shift
				;;
			"--kube-reset")
				f_kube_reset
				;;
			"--kube-full-reset")
				f_kube_full_reset
				;;
			"--kube-init")
				f_kube_init
				;;
			"--docker-build" | "db")
				f_docker_build $1
				shift
				;;
			"--docker-stop" | "ds")
				f_docker_stop $1
				shift
				;;
			"--docker-kill" | "dk")
				f_docker_kill $1
				shift
				;;
			"--docker-clean")
				f_docker_clean
				;;
			*)
				echo "Wrong args"
				print_failed
				;;
		esac
	done
	return 0
}


f_kube_deployment_reset()
{
	eval $(minikube -p minikube docker-env)
	if [[ -n $( kubectl get all|grep deployment.apps |grep $1) ]]
	then
		kubectl delete $(kubectl get all|grep deployment.apps|grep $1|awk '{print $1}') || return 1
	fi
	f_docker_build $1 || return 1
	kubectl apply -f "$v_path_setup/srcs/$(ls srcs|grep -e "$1.yaml")" || return 1
}

f_check_kube_version()
{
	minikube_version=$( minikube version |grep version|sed 's/minikube version: v//g' )
	if [[ $minikube_version != "$v_kube_needed_version" ]]
	then
		echo "Minikube version is not $v_kube_needed_version, Installing..."
		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 || return 1
		sudo install minikube-linux-amd64 /usr/local/bin/minikube || return 1
	else
		echo "Minikube version OK"
	fi
	return 0
}

f_docker_stop()
{
	docker stop $(docker ps|grep $1 |awk '{print $1}')
}

f_docker_kill()
{
	docker kill $(docker ps|grep $1 |awk '{print $1}')
}

f_docker_clean()
{
	docker kill $(docker ps -q)
	docker rm $(docker ps -a -q)
	#docker rmi $(docker images -q -f dangling=true)
	#docker rmi $(docker images -q)
}

f_docker_build()
{
	if [[ "$1" = "all" ]]
	then
		echo -e "${YELLOW}=== DOCKER_BUILD ===${NC}"
		echo -e "${YELLOW}=== mysql ===${NC}"
		docker build -t mysql $v_path_dock_mysql && print_success || print_failed
		echo -e "${YELLOW}=== phpmyadmin ===${NC}"
		docker build -t phpmyadmin $v_path_dock_phpmyadmin && print_success || print_failed
		echo -e "${YELLOW}=== wordpress ===${NC}"
		docker build -t wordpress $v_path_dock_wordpress && print_success || print_failed
		echo -e "${YELLOW}=== nginx ===${NC}"
		docker build -t nginx $v_path_dock_nginx && print_success || print_failed
		echo -e "${YELLOW}=== ftps ===${NC}"
		docker build -t ftps $v_path_dock_ftps && print_success || print_failed
		echo -e "${YELLOW}=== influxdb ===${NC}"
		docker build -t influxdb $v_path_dock_influxdb && print_success || print_failed
		echo -e "${YELLOW}=== grafana ===${NC}"
		docker build -t grafana $v_path_dock_grafana && print_success || print_failed
	else
		docker build -t $1 "$v_path_setup/srcs/$1" && print_success || print_failed
	fi
	return 0
}

f_docker_run_detach()
{
	f_docker_build all
	if [[ $1 == "all" ]]
	then
		docker kill $(docker ps -q)
		docker rm $(docker ps -a -q)
		docker run -d --rm -p 8086:8086 influxdb
		docker run -d --rm -p 3000:3000 grafana
		docker run -d --rm -p 3306:3306 mysql
		docker run -d --rm -p 5000:5000 phpmyadmin
		docker run -d --rm -p 5050:5050 wordpress
		docker run -d --rm -p 80:80 -p 443:443 nginx
		docker run -d --rm -p 21:21 -p 50000:50000 ftps
	else
		case $1 in 
			"influxdb")
				docker run -d --rm -p 8086:8086 influxdb
				;;
			"grafana")
				docker run -d --rm -p 3000:3000 grafana
				;;
			"mysql")
				docker run -d --rm -p 3306:3306 mysql
				;;
			"phpmyadmin")
				docker run -d --rm -p 5000:5000 phpmyadmin
				;;
			"wordpress")
				docker run -d --rm -p 5050:5050 wordpress
				;;
			"nginx")
				docker run -d --rm -p 80:80 -p 443:443 nginx
				;;
			"ftps")
				docker run -d --rm -p 21:21 -p 50000:50000 ftps
				;;
			*)
				echo "Wrong args"
				print_failed
				;;
		esac
	fi
}

f_kube_reset()
{
	if [[ $v_os = "$v_mac_os" ]]
	then
		echo "Reset minikube for $v_os"
		cd ~
		minikube stop
		minikube delete
		minikube start
		eval $(minikube -p minikube docker-env)
	fi
}

f_kube_full_reset()
{
	if [[ $v_os = "$v_mac_os" ]]
	then
		echo "Full reset minikube for $OS"
		cd ~
		minikube stop
		minikube delete
		rm -rf ~/.minikube
		rm -rf $v_goinfre_path/.minikube
		mkdir -p $v_goinfre_path/.minikube
		ln -sf $v_goinfre_path/.minikube ~/.minikube
		minikube config set vm-driver virtualbox
		minikube config set memory 4096
		minikube config set cpus 3
		minikube start
		eval $(minikube -p minikube docker-env)
	fi
}

f_kube_apply_metallb()
{
	kubectl apply -f srcs/metallb.yaml ||return 1
	kubectl apply -f srcs/configmap_metallb.yaml||return 1
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" || return 1
	print_success || return 1
	return 0
}

f_kube_apply_kube_conf()
{
	minikube addons enable dashboard||return 1
	minikube addons enable metrics-server||return 1
	kubectl apply -f srcs/configmap.yaml ||return 1
	kubectl apply -f srcs/secret.yaml ||return 1
	print_success || return 1
	return 0
}

f_kube_apply_deployment()
{
	kubectl apply -f srcs/influxdb.yaml ||return 1
	kubectl apply -f srcs/grafana.yaml ||return 1
	kubectl apply -f srcs/mysql.yaml ||return 1
	kubectl apply -f srcs/phpmyadmin.yaml ||return 1
	kubectl apply -f srcs/wordpress.yaml ||return 1
	kubectl apply -f srcs/nginx.yaml ||return 1
	kubectl apply -f srcs/ftps.yaml ||return 1
	print_success || return 1
	return 0
}

case "$v_os" in
	"42mac")
		f_42mac
		;;
	"debian")
		f_debian
		;;
	"42xubuntu")
		f_42xubuntu
		;;
esac
v_path_dock_mysql="$v_path_setup/srcs/mysql"
v_path_dock_phpmyadmin="$v_path_setup/srcs/phpmyadmin"
v_path_dock_wordpress="$v_path_setup/srcs/wordpress"
v_path_dock_nginx="$v_path_setup/srcs/nginx"
v_path_dock_ftps="$v_path_setup/srcs/ftps"
v_path_dock_influxdb="$v_path_setup/srcs/influxdb"
v_path_dock_grafana="$v_path_setup/srcs/grafana"

if [[ $# -eq 0 ]]
then
	f_check_kube_version||return 1
	if [[ $( minikube status|grep host|awk '{print $2}' ) != "Running" ]]
	then
		echo "Starting minikube"
		minikube start
	fi
	eval $(minikube -p minikube docker-env)
	f_docker_build all || exit 1
	v_ip=$( minikube ip )
	sed -i -E "s/      - *.*/      - $v_ip-$v_ip/g" srcs/configmap_metallb.yaml
	sed -i -E "s/  minikube_ip:*.*/  minikube_ip: $v_ip/g" srcs/configmap.yaml
	f_kube_apply_metallb || return 1
	f_kube_apply_kube_conf || return 1
	f_kube_apply_deployment || return 1
	echo -e "${GREEN}FT_SERVICES${NC}"; print_success
	minikube dashboard
	exit 0
fi
f_check_args $@ || exit 1
exit 0
