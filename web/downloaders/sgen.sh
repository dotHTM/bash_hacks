#!/usr/bin/env bash
# sgen.sh
#   Description
#
#   Written by Mike Cramer
#   Started on 2016-06-24T08:56:13-05:00

main (){

	# parse URLs for domain
		# if non unique, error and halt

	# check for settings file
	settingsFile=".settings"
	cookiesFile="cookies.txt"
	
	if [[ ! -e $cookies.txt ]]; then
		# if not exists
		if [[ ! -e $settingsFile ]]; then
			# prompt for user input and write Settings file
			promptSettings $settingsFile
		fi
		if [ "$1" == "config" ]; then
			promptSettings $settingsFile
		fi
		if [ "$1" == "reset" ]; then
		if [[ -e $settingsFile ]]; then
			# prompt for user input and write Settings file
			rm $settingsFile
		fi
			promptSettings $settingsFile
		fi
	
		# else read settings file
	
	
		domain=`readFile $settingsFile | grep "domain" | perl -pe "s/.*=//gi"`
		username=`readFile $settingsFile | grep "username" | perl -pe "s/.*=//gi"`
		password=`readFile $settingsFile | grep "password" | perl -pe "s/.*=//gi"`
		csrfTokenFormFieldName=`readFile $settingsFile | grep "csrfTokenFormFieldName" | perl -pe "s/.*=//gi"`
		pathFilterText=`readFile $settingsFile | grep "pathFilterText" | perl -pe "s/.*=//gi"`
		logonURL="https://${domain}"
		authCookie $logonURL $username $password $csrfTokenFormFieldName $cookiesFile
	fi
	
	# attempt to authenticate
		# if failed
			# prompt for user input and write Settings file
		# else write cookie file
	
	# Take URL inputs and filter against settings domain
		# run downloader
		
		
		documentURL="https://www.suicidegirls.com/girls/aymi/album/2551227/love-me-tender/"

getAuthPage $documentURL $cookiesFile

}

promptSettings () {
	settingsFile=$1
	
	echo "----------------"
	echo "Domain:"
	read -p "  > " domain
	echo "domain=$domain" >> $settingsFile
	echo "  -  -  -  -"
	echo "Username:"
	read -p "  > " username
	echo "username=$username" > $settingsFile
	echo "Password:"
	read -p "  > " -s password
	echo "password=$password" >> $settingsFile
	echo
	echo "  -  -  -  -"
	echo "CSRF Token Form Field Name:"
	read -p "  > " csrfTokenFormFieldName
	echo "csrfTokenFormFieldName=$csrfTokenFormFieldName" >> $settingsFile
	echo "Path Filter Text"
	read -p "  > " pathFilterText
	echo "pathFilterText=$pathFilterText" >> $settingsFile
	echo "----------------"
	
}


readFile () {
	aFile=$1
	while read line; do
		echo $line
	done < $aFile
}







# authCookie
# 	Authenticate and save Cookie file
# Usage:
# 	authCookie $logonURL $username $password "csrfmiddlewaretoken" "./cookies.txt"

authCookie () {
	logonURL=$1
	username=$2
	password=$3
	csrfTokenFieldName=$4
	cookieFile=$5
	curl -X "GET" \
		-c $cookieFile \
		"${logonURL}"
	csrftoken=`cat $cookieFile | grep csrftoken | perl -pe "s/.*csrftoken\s+//gi"`
	curl --data "username=${username}&password=${password}&${csrfTokenFieldName}=${csrftoken}" \
		-b $cookieFile \
		-e "${logonURL}" \
		"${logonURL}"
}



# getAuthPage
# 	curl a page that requires an authenticated session
# Usage:
# 	authCookie $documentURL "./cookies.txt"

getAuthPage () {
	documentURL=$1
	cookieFile=$2

	curl \
		-b $cookieFile \
		"${logonURL}"
}



main $@

main $@