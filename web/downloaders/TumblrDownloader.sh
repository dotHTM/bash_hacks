#!/bin/bash
#
# TumblrDownloader - Mirror the content of a tumblr URL
#
#   Script written by Mike Cramer, started April 16, 2012.
#   If released to the public, assume this is under a BSD/GPL style license.
#
#   Questions about this script? Send a message to kiodane@gmail.com.

tumblrURL=$1

mkdir -p $tumblrURL
cd $tumblrURL

wget -mpNHk --random-wait -e robots=off -D .media.tumblr.com,$tumblrURL -R "*avatar*","*\?*","*_[0-9][0-9][0-9].*" http://$tumblrURL -o wgetLog.txt

## ,"*.gif"

cd ..



echo Done with $tumblrURL
echo
echo '- -'
echo



