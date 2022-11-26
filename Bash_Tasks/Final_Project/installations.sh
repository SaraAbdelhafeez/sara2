#!/usr/bin/env bash

system()
{
	sudo yum update -y
	echo "System Updated"
	sudo yum upgrade -y
        echo "System Upgrated"
}

epel_release()
{
	sudo yum install epel-release
	echo "EPEL is installed"
	sudo yum --enablerepo="epel" list available
	echo "EPEL is enabled"
}

fail2ban()
{
        sudo yum install fail2ban -y
	echo "fail2ban is installed"
	sudo systemctl enable fail2ban
        sudo systemctl start fail2ban
	echo "fail2ban is enabled"
}



