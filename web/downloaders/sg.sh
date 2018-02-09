#!/usr/local/bin/bash

# A downloader to backup one's investment in a site using CDN for assets outside authentication.

#    Of course, you should collect your session token and ID on your own. This might expire from time to time, and you should never share your session with anyone else.

csrftoken=""
sessionID=""

dlAlbum() {
	targetURL=$1

	filePrefix=`echo $targetURL | perl -pe "s|.*/(\w)|\1|gi; s|/.*||gi"`
	groupDirName=`echo $targetURL | perl -pe "s~.*/(g[aeiou]rls/|m[aeiou]mb[aeiou]rs/)~\1~gi; s~(.*?/.*?)/.*~\1~gi"`
	dlDir="/Users/$USER/Desktop/sg/${groupDirName}/${filePrefix}"

	rawtext=`curl -X "GET" "${targetURL}" -H "Cookie: csrftoken=${csrftoken}; sessionid=\"${sessionID}\""`
	fileList=`echo $rawtext | perl -pe "s|href|\n$&|gi; s|href=\"||gi; s|\".*||gi" | grep cloudfront | grep jpg `
	mkdir -p $dlDir
	cd $dlDir
	echo $fileList > files.txt # Just so you can have a listing of the origin URLS. Completely accessable outside of authentication!

	mycount=0
	for anFile in $fileList; do
		sleep 1
		mycount=$((mycount+1))
		myNumber=`printf "%03g" $mycount`
		curl $anFile -o "${filePrefix}_${mycount}".jpg
	done
}

until [ -z "$1" ]  # Until all parameters used up . . .
do
	echo
	echo "$1 "
	dlAlbum $1
	shift
done
