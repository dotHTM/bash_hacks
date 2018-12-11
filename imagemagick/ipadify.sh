#!/usr/bin/env bash
# ipadify.sh
#   Reduces the size of images in a directory around the size of a retina iPad
#
# Written by Mike Cramer
#   Started on 2016-06-19
#

resizeDir() {
	originDir=$1
	targetDir="${originDir}_sml"

	cp -van ${originDir} ${targetDir}

	# find ${targetDir} BLAH

}

until [ -z "$1" ]  # Until all parameters used up . . .
do
	echo
	echo "$1 "
	resizeDir $1
	shift
done
