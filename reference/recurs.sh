#!/bin/bash
#
# 

recursEcho() {
	if [[ ! -n $2 ]]; then
		echo $1
	elif [[ condition ]]; then
		echo $1
		shift
		recursEcho $@
	fi
}

recursEcho "hello" "there" "world"

