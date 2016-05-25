#!/bin/bash
#
# 

baseDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

secondaryList='public
private'

for secondaryDir in $secondaryList; do
	for anFile in `find $baseDir/$secondaryDir -iname "*.sh"`; do
		source $anFile
	done
done


