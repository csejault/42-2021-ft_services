#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csejault <csejault@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/09 15:31:47 by csejault          #+#    #+#              #
#    Updated: 2021/04/12 12:13:04 by csejault         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


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

#To Install brew
#rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
#brew install minikube

v_goinfre_path="/goinfre/csejault"
v_kube_mac="./minikube-darwin-amd64"
v_kube_needed_version="1.19.0"
v_mac_os="mac"
v_path_setup="/sgoinfre/goinfre/Perso/csejault/ft_services"
v_path_dock_mysql="$v_path_setup/srcs/mysql"
v_path_dock_wordpress="$v_path_setup/srcs/wordpress"
v_path_dock_nginx="$v_path_setup/srcs/nginx"
f_check_args()
{
	if [[ $1 != "--os="* ]]
	then
		echo "need the os flag in first position"
		return 1
	else
		v_os=$(echo $1|sed 's/--os=//g')
		shift;
		echo "OS = $v_os"
	fi
	while [[ $# > 0 ]] ;
	do
		arg="$1"
		shift;
		case "$arg" in
			"--kube-reset")
				f_kube_reset
				;;
			"--kube-full-reset")
				f_kube_full_reset
				;;
			"--docker-build")
				f_docker_build
				;;
			*)
				echo "Wrong args"
				return 1
				;;
		esac
	done
	return 0
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
		minikube start
		eval $(minikube -p minikube docker-env)
	fi
}

f_check_kube_version()
{
	minikube_version=$( minikube version |grep version|sed 's/minikube version: v//g' )
	if [[ $minikube_version != "$v_kube_needed_version" ]]
	then
		echo "Minikube version is not $v_kube_needed_version"
	fi
}

f_docker_build()
{
	echo -e "${YELLOW}=== DOCKER_BUILD ===${NC}"
	echo -e "${YELLOW}=== mysql ===${NC}"
	docker build -t mysql $v_path_dock_mysql
	echo -e "${YELLOW}=== wordpress ===${NC}"
	docker build -t wordpress $v_path_dock_wordpress
	echo -e "${YELLOW}=== nginx ===${NC}"
	docker build -t nginx $v_path_dock_nginx
}


#f_check_kube_version
f_check_args $@ || exit 1
exit 0
