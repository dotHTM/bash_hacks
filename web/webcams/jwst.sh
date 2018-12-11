#!/usr/bin/env bash

getImage() #description camDir camImage
{
	description=$1
	camDir=$2
	camImage=$3
	
	camPath="${camDir}${camImage}"
	destinPath="/Users/$USER/Documents/Image/NASA/${description}"
	
	mkdir -p $destinPath
	cd $destinPath

	curl $camPath -R -O 
	
	fileDate=`stat -t "-%Y%m%d-%H%M%S" "$camImage" | perl -pe 's|.*?"-(.*?)".*|\1|gi'`
	
	mv "$camImage" "$fileDate-$camImage"
	
}

getImage "JWST-cleanroom-1" "http://jwst.nasa.gov/WebbCam/" "CLNRMR.jpg"
getImage "JWST-cleanroom-2" "http://jwst.nasa.gov/WebbCam/" "CLNRM.jpg"
