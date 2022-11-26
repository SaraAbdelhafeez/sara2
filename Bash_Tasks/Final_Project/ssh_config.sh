#!/usr/bin/env bash


port=$1

set_port_num()
{	
	
	sudo sed -i "s/^#Port 22$/Port $port/g" /etc/ssh/sshd_config
	echo "SSH Port is set to $port"

}

disable_root_login()
{
	sudo sed -i "s/^PermitRootLogin yes$/PermitRootLogin no/g" /etc/ssh/sshd_config
	echo "Root Login Disabled"
}


update_selinux()
{
	sudo sed -i "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config
	sudo setenforce 0
	echo "SELINUX Disabled"
	

}

update_firewall()
{
	 
	sudo firewall-cmd --add-port=$port/tcp --permanent
	sudo firewall-cmd --remove-service=ssh --permanent
	echo "Firewall Updated to port $port"
	sudo semanage port -a -t ssh_port_t -p tcp $port
	echo "Semanage Updated to port $port"
}


