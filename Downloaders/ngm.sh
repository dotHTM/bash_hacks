#!/bin/bash

# National Geographic Wallpapers

TargetURL="http://ngm.nationalgeographic.com/wallpaper/"
saveDIR="/Users/$USER/Desktop/mir/ngm/"

#rm -rf $saveDIR/*

mkdir -p $saveDIR
cd $saveDIR

MonthlyURLs=`curl $TargetURL | grep "option value" | perl -pe 's|.*/wallpaper(.*?)">.*|$1|gi' | grep "/20" | perl -pe "s|^|$TargetURL|gi"`

for anURL in $MonthlyURLs; do
	wget -m  -e robots=off -I "wallpaper" -A "*_[1-9][0-9][0-9][0-9].*"  $anURL
done

echo
echo
echo " ### All Done "

