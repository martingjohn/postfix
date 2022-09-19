#!/bin/bash

IFS=$(echo -en "\n\b")
for i in $(env | grep POSTCONF_ | sort)
do
	i=${i#POSTCONF_}
	#echo "$i"
	echo postconf -e $i
	postconf -e $i
done

if [[ "x$POSTFIX_SASL_PASSWD" -ne "x" ]]
then
	cp ${POSTFIX_SASL_PASSWD} /etc/postfix/sasl_passwd
	chown root:root /etc/postfix/sasl_passwd
	chmod 600 /etc/postfix/sasl_passwd
	postmap /etc/postfix/sasl_passwd
fi


#postfix start-fg
