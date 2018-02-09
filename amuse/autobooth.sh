#!/usr/local/bin/bash

# Autobooth time lapse snapper.
#
#   This uses the imagesnap utility that you can install via MacPorts
# `port install imagesnap`

myHostName=`hostname`
myDate=`date "+%Y-%m-%d-%H%M%S%z"`
myFileName="$myDate - $myHostName"
myFileExt=".jpg"

myHomeFolder="/Users/$USER"

mySavedParent="$myHomeFolder/Pictures/autobooth/$myHostName"
myFilePath="$mySavedParent/$myFileName$myFileExt"

linkFolderPath="$myHomeFolder/Pictures/"
linkedFileName="last_AutoBooth"
linkPath="$linkFolderPath$linkedFileName$myFileExt"

mkdir -p "$mySavedParent"
cd "$mySavedParent"

~/Applications/imagesnap -q "$myFilePath"

# touch "$myFilePath.touch"

rm -f "$linkPath"
ln "$myFilePath" "$linkPath"

exit 0
