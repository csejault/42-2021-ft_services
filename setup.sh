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

#To Install brew
#rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
#brew install minikube

v_goinfre_path="/goinfre/csejault"
v_kube_mac="./minikube-darwin-amd64"
v_kube_needed_version="1.19.0"
v_mac_os="mac"

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

f_check_kube_version
f_check_args $@ || exit 1
exit 0
