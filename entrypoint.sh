#!/bin/bash

IFS=$(echo -en "\n\b")

for i in $(env | grep POSTMAP_ | sort)
do
	i=${i#POSTMAP_}
	J=$(eval echo ${i#*=})
	I=${i,,}
	I=${I%=*}
	if [[ -f $J ]]
	then
		echo cp $J /etc/postfix/$I
		cp $J /etc/postfix/$I
		chown root:root /etc/postfix/$I
		chmod 600 /etc/postfix/$I
		echo Making map of $I
		postmap /etc/postfix/$I
	fi
done

for i in $(env | grep POSTCONF_ | sort)
do
	i=${i#POSTCONF_}
	#echo "$i"
	echo postconf -e $i
	postconf -e $i
done

#Set logging to stdout
postconf -e maillog_file=/dev/stdout

postfix start-fg
