#!/bin/bash
#
#

profileDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for anFile in `find $profileDir/public -iname "*.sh"`; do
	# echo $anFile
  source $anFile
done




