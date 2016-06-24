#!/bin/bash
# sgen.sh
#   Description
#
#   Written by Mike Cramer
#   Started on 2016-06-24T08:56:13-05:00

main (){
	
	settingsFile=".settings"
	
	if [[ ! -e $settingsFile ]]; then
		promptSettings $settingsFile
	fi
	
	if [ "$1" == "config" ]; then
		promptSettings $settingsFile
	fi
	
	username=`readFile $settingsFile | grep "username" | perl -pe "s/.*=//gi"`
	password=`readFile $settingsFile | grep "password" | perl -pe "s/.*=//gi"`
	csrfTokenFormFieldName=`readFile $settingsFile | grep "csrfTokenFormFieldName" | perl -pe "s/.*=//gi"`
	
	echo $username
	echo $password
	echo $csrfTokenFormFieldName
}

promptSettings () {
	settingsFile=$1
	
	echo "----------------"
	echo "Username:"
	read -p "  > " username
	echo "username=$username" > $settingsFile
	echo "Password:"
	read -p "  > " -s password
	echo "password=$password" >> $settingsFile
	echo
	echo "CSRF Token Form Field Name:"
	read -p "  > " csrfTokenFormFieldName
	echo "csrfTokenFormFieldName=$csrfTokenFormFieldName" >> $settingsFile
	echo "----------------"
	
}


readFile () {
	aFile=$1
	while read line; do
		echo $line
	done < $aFile
}




main $@