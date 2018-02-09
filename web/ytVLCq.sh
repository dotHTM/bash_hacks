#!/usr/local/bin/bash

# Get YouTube links off a page and open them in VLC as a playlist.

targetURL="$1"
#targetURL="https://www.youtube.com/user/$1/videos"
#targetURL=$1; targetURL=`echo $targetURL | perl -pe 's|\?.*||gi'`
tURLmd5=`echo $targetURL | md5`

echo "targetURL    $targetURL"
echo "tURLmd5      $tURLmd5"
echo


history_check=0
# History Path
historyPath="/Users/$USER/.ytVLCq/"
mkdir -p $historyPath
historyFile=$historyPath$tURLmd5.m3u

#if [ ! -a $historyFile ]; then
	echo "#EXTM3U" > $historyFile
#fi

## Scrape the orders page with the session cookie.
pageContent=`curl "$targetURL"`
videoLinks=`echo $pageContent | perl -pe 's|>|>\n|gi' | grep 'watch?v=' | grep '<a href='|  perl -pe 's|<a href="(.*?)".*|$1|gi'` # | tail -r`
echo

for anVideo in $videoLinks; do


#	if [ "$history_check" == "1" ]; then
#		# Check if found in the history file
#		test_item=$anVideo
#		test_found=0
#		for an_line in `cat $historyFile`; do
#			if [ "$test_found" == "0" ] &&  [ "$an_line" == "$test_item" ]; then
#				test_found=1
#			fi
#		done
#	fi
	
#	if [ "$test_found" == "0" ] || [ "$history_check" == "0" ]; then
		# Do stuff
#		open -a /Applications/VLC.app "https://www.youtube.com$anVideo"; sleep 2
		echo "  Found $anVideo"
		echo "https://www.youtube.com$anVideo" >> $historyFile
#	fi

done

open -a /Applications/VLC.app $historyFile
