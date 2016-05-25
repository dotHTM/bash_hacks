#!/bin/bash
##
## Add Meh Tracking numbers to Deliveries Mac App via URL Scheme. (and checking for items previously found by this script.)

## Get your session token from your cookies file or a cookies editor (such as in Chrome Store). This is the "Value" for the "session.meh.com" cookie.
YOUR_SESSION_TOKEN=$1
## DELETE YOUR SESSION TOKEN IF YOU SHARE THIS SCRIPT!!!!

## I use iCloud, you can use Dropbox, or whatever.
#YOUR_HISTORY_DIRECTORY="/Users/$USER/icd/devel/txt/"
#YOUR_HISTORY_DIRECTORY="/Users/$USER/Dropbox/"
#YOUR_HISTORY_DIRECTORY="/somefolder/"

history_check=0
# History Path
historyPath="/Users/$USER/Dropbox/dev/txt/"
mkdir -p $historyPath
historyFile=$historyPath"meh_del_hist.txt"
touch $historyFile



## Scrape the orders page with the session cookie.
pageContent=`curl -b "session.meh.com=$YOUR_SESSION_TOKEN" "https://meh.com/orders"`



if [ `echo $pageContent | grep 'Moved Temporarily. Redirecting' | wc -l` == "1" ]; then
	echo
	echo "cookie invalid or not signed in"
else
	echo
	echo "Looking for new items"
	echo

	IFS= ;x=$(ls -1) ;  IFS=$'\n'
	for an_line in $pageContent; do

		# Find names in source
		if [ `echo $an_line | grep 'offer-name' | wc -l` -ge "1" ]; then
			last_found_name=`echo $an_line | perl -pe 's|.*?offer-name">(.*?)</span>.*|$1|gi'`
		fi

		# Find tracking number in source
		if [ `echo $an_line | grep '<a href="https://www.google.com/#q=' | wc -l` -ge "1" ]; then
			found_number=`echo $an_line | perl -pe 's|.*?q=(.*?)".*|$1|gi'`



				if [ "$history_check" == "1" ]; then
					# Check if found in the history file
					test_item=$found_number
					test_found=0
					for an_line in `cat $historyFile`; do
						if [ "$test_found" == "0" ] &&  [ "$an_line" == "$test_item" ]; then
							test_found=1
						fi
					done
				fi
				
				if [ "$test_found" == "0" ] || [ "$history_check" == "0" ]; then
					# Do stuff
#					open "deliveries://add?from=www.usps.com&name=$last_found_name&no=92$found_number"
					echo Found New Item $last_found_name - $found_number
#					echo $found_number >> $YOUR_HISTORY_FILE
				fi


		fi
	done
	echo
	echo "done"

fi


