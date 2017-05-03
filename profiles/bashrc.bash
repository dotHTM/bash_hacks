#!/bin/bash
#

profileDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for anFile in `find $profileDir/public -iname "*.bash"`; do
	# echo $anFile
  source $anFile
done

if [[ -n $PrivateBASHRCPath ]]; then
  for anFile in `find $PrivateBASHRCPath -iname "*.bash"`; do
    # echo $anFile
    source $anFile
  done
fi