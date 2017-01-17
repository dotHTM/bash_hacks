#!/bin/bash
#
# 

profileDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

secondaryProfileDir='public
private
plugins'

shellFileTypes='sh
bash'

for secondaryDir in $secondaryProfileDir; do
	for anFileType in $shellFileTypes; do
		for anFile in `find $profileDir/$secondaryDir -iname "*.$anFileType"`; do
			source $anFile
		done
	done
done


