#!/bin/bash

# Echo with Lolcat (installable w/ ruby gem)

lolstatus="1"
command -v lolcat >/dev/null 2>&1 || { lolstatus="0"; }
export LOLSTAT=$lolstatus

if [ "$LOLSTAT" == "1" ]
then
	echo "$@" | lolcat
else
	echo "$@"
fi

