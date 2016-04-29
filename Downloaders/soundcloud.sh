#!/bin/bash
#
# Download music tracks off Sound

# Get this info from your browser. Load up a track and check the inspectors for the API call to grab the streams. Get from API URL call. I'm not sure if these are session specific, perhaps related to login session, so consider NOT sharing. Plus likely to be invalidated durring normal SoundCloud development.

appVersion=""
clientID=""

main()
{
	inputUrls=$@
	cd /Users/$USER/Downloads/
	getManyTracks $inputUrls
	
	# TODO: Detect if Artist page, or if track page, handle accordingly.
}


getManyTracks()
{
	urlList=$@
	for anUrl in $urlList; do
		echo
		echo $anUrl
		getAnTrack $anUrl
		sleep 2
	done
}

getAnTrack()
{
	targetURL=$1
	rawCode=`curl -s $targetURL`
	pageTitle=`echo $rawCode | perl -pe 's|>|>\n|gi; s|<|\n<|gi; s|;|;\n|gi;' | grep "twitter:title" | perl -pe 's|.*content="(.*?)".*|$1|gi'`
	
	# TOFIX: Terrible handling of quotations inside track name....
	
	trackID=`echo $rawCode | perl -pe 's|>|>\n|gi; s|<|\n<|gi; s|;|;\n|gi;' | grep "tracks%2F" | grep "twitter:player" | perl -pe 's|.*tracks%2F(\d+)&amp;.*|$1|gi'`
	
	# TODO: if trackID is empty, report error, exit
	
	trackURL=`curl -s "https://api.soundcloud.com/i1/tracks/${trackID}/streams?client_id=${clientID}&app_version=${appVersion}" | perl -pe 's|.*(https://cf-media.sndcdn.com.*?)".*|$1|gi; s|\\u0026|&|gi'`
	
	# TODO: if trackURL is empty, report error, exit
	
	curl -s "${trackURL}" -o "${pageTitle}.mp3"
	echo "Saved: ${trackURL}"
}

getAnArtist()
{
	targetURL=$1
	rawCode=`curl -s $targetURL`
	pageTitle=`echo $rawCode | perl -pe 's|>|>\n|gi; s|<|\n<|gi; s|;|;\n|gi;' | grep "twitter:title" | perl -pe 's|.*content="(.*?)".*|$1|gi'`
	artistName=`echo $rawCode | perl -pe 's|>|>\n|gi; s|<|\n<|gi; s|;|;\n|gi;' | grep "\"full_name\"" | perl -pe 's|.*"full_name":"(.*?)".*|$1|gi'`
	artisitString="${artistName} (${pageTitle})"
	
	# TODO: Get Track URLs, then getManyTracks.
}





main $@