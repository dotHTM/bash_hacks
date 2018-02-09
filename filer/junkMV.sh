#!/usr/local/bin/bash


myDate=`date "+%Y-%m-%d-%H%M%S"`

mkdir -p ~/Desktop/Junk/$myDate/

for anPath in "$@"
do
	mv -v "$anPath" ~/Desktop/Junk/$myDate/
done


