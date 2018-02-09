#!/usr/local/bin/bash
# fileCount.sh
#   COUNT FILES IN A DIRECTORY
#
#   Written by Mike Cramer
#   Started on 2016-06-30T13:56:10-05:00

main () {
	dirList=`find ./ -type d -d 1`
	
	while read anLine; do
		dirCount "$anLine"
	done <<< "$dirList"
}

dirCount () {
	echo -n "$1 	-	"
	find "$1" | wc -l
}

main $@