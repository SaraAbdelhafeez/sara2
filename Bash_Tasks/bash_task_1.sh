#!/usr/bin/env bash

# Sara Mahmoud Abdelhafeez

cd ~

#to get the number of days in each month
get_last_day() {
        month=$1
        let NEXTM=${month}+1
        if [[ $NEXTM -eq 13 ]]
        then
                LAST_DAY=31
        else
                LAST_DAY=$(date -d "$(date +%Y-$NEXTM-01) -1 day" +%d)
        fi
        echo $LAST_DAY
}


if [[ -d ~/Reports ]]
then
	echo "the directory \"Reports\" is already exist"
	if [[ ! -d ~/Reports/$(date +%Y) ]]
	then
		mkdir ~/Reports/$(date +%Y)
		for month in $(seq 1 12)
		do 
			
			last_day=$(get_last_day $month)


			mkdir ~/Reports/$(date +%Y)/${month}
			for day in $(seq -w 01 $LAST_DAY)
			do
				touch ~/Reports/$(date +%Y)/${month}/${day}.xls
		
			done
		done
	else
		echo "the directory $(date +%Y) is already exist"
		for month in $(seq 1 12)
		do
			if [[ ! -d ~/Reports/$(date +%Y)/${month} ]]
			then 
				last_day=$(get_last_day $month)
					
				mkdir ~/Reports/$(date +%Y)/${month}
				for day in $(seq -w 01 $last_day)
				do 
					touch ~/Reports/$(date +%Y)/${month}/${day}.xls
				done
			else
				echo "the directory of month $(date +%m) is already exist"

				last_day=$(get_last_day $month)

				for day in $(seq -w 01 $last_day)
				do
					if [[ ! -f ${day}.xls ]]
					then
						touch ~/Reports/$(date +%Y)/${month}/${day}
					fi
				done
			fi
		done
	fi
else
	mkdir ~/Reports
	echo "the directory \"Reports\" is created"
	mkdir ~/Reports/$(date +%Y)
	for month in $(seq 1 12)
                do
			last_day=$(get_last_day $month)

                        mkdir ~/Reports/$(date +%Y)/${month}
			
			for day in $(seq -w 01 $last_day)
                        do
                                touch ~/Reports/$(date +%Y)/${month}/${day}
                        done
                done

	echo "the files are created"
fi





#for the backup 

echo "* 0-5 * * * root cp -R ~/Reports ~/Backup" >> /var/spool/cron/root

