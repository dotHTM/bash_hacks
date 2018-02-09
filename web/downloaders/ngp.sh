#!/usr/local/bin/bash

## National Geographic Photo of the Day


TargetURL="http://photography.nationalgeographic.com/photography/photo-of-the-day/"
saveDIR="/Users/$USER/Desktop/mir/ngp/"

mkdir -p $saveDIR
cd $saveDIR

wget -m -nd -H -D "photography.nationalgeographic.com","images.nationalgeographic.com" -e robots=off -I "wpf","photography/photo-of-the-day" -A "*_[1-9][0-9][0-9][0-9][.x]*" $TargetURL

## 

echo
echo
echo " ### All Done "

