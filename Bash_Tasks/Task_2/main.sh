#!/usr/bin/env bash

# Sara Mahmoud Abdelhafeez

file=$(pwd)/testfile
echo "Waiting until the file \"testfile\" is created here"

while [ 9 -lt 10 ]
do
	if [ -f ${file} ]
 	then
	 	echo "the file is created"
 		break
	fi
done

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

check_user

source bash_task_2.sh

check_user

set_port_num

disable_root_login

add_user

backup_fun


