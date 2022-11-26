#!/usr/bin/env bash

# Sara Mahmoud Abdelhafeez


check_user() 
{
	
	if [[ ${EUID} -eq 0 ]]
	then
		echo "The user has root privilages"
	else
		echo "The user \"doesn't\" have root privilages"
	fi

	
}

set_port_num()
{
	
	read -p "Please enter the port number: " port
	if [[ ${EUID} -eq 0 ]] 
	then
		sed -i "s/^#Port 22$/Port $port/g" /etc/ssh/sshd_config
	else
		sudo sed -i "s/^#Port 22$/Port $port/g" /etc/ssh/sshd_config
	fi
	echo "Port number changed successfully"
}

disable_root_login()
{
	if [[ ${EUID} -eq 0 ]]
	then
		sed -i "s/^PermitRootLogin yes$/PermitRootLogin no/g" /etc/ssh/sshd_config
	else
		sudo sed -i "s/^PermitRootLogin yes$/PermitRootLogin no/g" /etc/ssh/sshd_config
	fi
	echo "root login disabled"
}

add_user()
{
	
	echo "Please Enter The User Name"
	read username
	if [[ ${EUID} -eq 0 ]]
	then
		useradd $username
	else
		sudo useradd $username
	fi
	echo "$username is added"
	echo "Do you want to add this user to sudoers?(1/0)" 
	read ans
	if [[ $ans -ne 1 ]]
       	then
		
		echo "$username is added to normal users"
	else
		if [[ ${EUID} -eq 0 ]]
		then
			echo "$username    ALL=(ALL)       ALL" >> /etc/sudoers
		else
			echo "$username    ALL=(ALL)       ALL" | sudo EDITOR='tee -a' visudo -f /etc/sudoers
		fi
		echo "$username is added to sudoers users "
	fi

}

backup_fun()
{

	cd ~
	if [[ ${EUID} -eq 0 ]]
	then
		echo "* * * * * ${USER} cp -R $(pwd) $(pwd)/homeBackup" >> /var/spool/cron/${USER}
	else
	#	echo "* * * * * ${USER} cp -R $(pwd) $(pwd)/homeBackup" | sudo  EDITOR='tee -a' visudo -f /var/spool/cron/${USER}
	(cronrtab -1 2> /dev/null;echo "* * * * * ${USER} cp -R $(pwd) $(pwd)/homeBackup") | crontab -
	fi
	echo "the backup is added "
}
