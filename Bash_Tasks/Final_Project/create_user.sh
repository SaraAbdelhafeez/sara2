#!/usr/bin/env bash

username=$1
password=$2
add_group()
{
	sudo egrep "^Audit" /etc/group >/dev/null
	if [ $? -eq 0 ]; then
		echo "Audit exists!"
		
	else
		sudo groupadd -g 20000 Audit
		echo "Group Audit with GID 20000 is created"
	fi
}




add_user()
{
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		
	else
		pass=$(sudo perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p "$pass" "$username"
		if [[ $? -eq 0 ]];
       		then
	       		echo "User \"$username\" has been added to system!"
			sudo usermod -g  Audit $username
			echo "User \"$username\" has been added to group Audit"
		else	
			echo "Failed to add a user!"
		fi
	fi
}

get_last_day() {
        month=$1
        let NEXTM=${month}+1
        if [[ $NEXTM -eq 13 ]]
        then
                LAST_DAY=31
        else
                LAST_DAY=$(date -d "$(date +2021-$NEXTM-01) -1 day" +%d)
        fi
        echo $LAST_DAY
}

create_reports()
{
	sudo mkdir /home/$username/reports
	for month in $(seq  01 12)
	do
		last_day=$(get_last_day $month)
		for day in $(seq -w 01 $last_day)
		do
			sudo touch /home/$username/reports/2021-$month-$day.xls
		done
	done
	echo "the reports for user $username are created"
}


set_permissions()
{
	sudo chown -R $username /home/$username/reports 2> /dev/null
	echo "Now $username is the owner of reports"
	sudo chmod -R -rwx /home/$username/reports
	sudo chmod -R 660 /home/$username/reports 2> /dev/null
	echo "Permission changed"

}

reports_backup()
{
	
	if [[ ${EUID} -eq 0 ]]
	then
		echo "0 1 * * 1-6 ${USER} tar -cf /root/backups/reports-$(date +%U)-$(date +%A).tar /home/$username/reports" >> /var/spool/cron/${USER}
	else
		
		(cronrtab -1 2> /dev/null;echo "0 1 * * 1-6 ${USER} tar -cf /root/backups/reports-$(date +%U)-$(date +%A).tar /home/$username/reports") | crontab -
	
	fi
	echo "The backup will be done every day from MON to FRI every day ar 01AM"
	
}

reports_sync()
{

	egrep "^manager" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "manager exists!"
               
	else
		sudo useradd -u 30000 manager
	fi
	if [[ ${EUID} -eq 0 ]]
	then
		echo "0 2 * * 1-6 ${USER} rsync -av /home/$username/reports /home/manager/audit/reports" >> /var/spool/cron/${USER}
	else
		(cronrtab -1 2> /dev/null;echo "0 2 * * 1-6 ${USER} rsync -av /home/$username/reports /home/manager/audit/reports") | crontab -
	fi
	echo "The Sync will be done every day from MON to FRI every day ar 02AM"
}
