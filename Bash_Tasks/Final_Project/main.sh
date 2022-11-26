#!/usr/bin/env bash




check_user()
{

	username=$(sudo awk "/^${USER} /" /etc/sudoers | sudo awk '{print $1}' 2>&1) 
	if [[ $username -eq $USER ]];
	then
	       	echo "$USER are sudoer"	
	else
		
		echo "$USER is not a sudoer"
		echo "you must run the script as a root or a sudoer"
		exit 1
	fi


}

port=$1
username=$2
password=$3

source ssh_config.sh $port

set_port_num 

disable_root_login

update_selinux

update_firewall

source create_user.sh $username $password

add_group

add_user

create_reports

set_permissions

reports_backup

reports_sync

source installations.sh

system

epel_release

fail2ban
