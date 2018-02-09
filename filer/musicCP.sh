#!/usr/local/bin/bash


for anPath in "$@"
do
	cp -pRvn "$anPath" ~/Music/iTunes/iTunes\ Media/Automatically\ Add\ to\ iTunes.localized/
done


