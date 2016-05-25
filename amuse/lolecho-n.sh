#!/bin/bash

# Echo with Lolcat (installable w/ ruby gem)

lolstatus="1"
command -v lolcat >/dev/null 2>&1 || { lolstatus="0"; }

if [ "$lolstatus" == "1" ]
then
	echo -n "$@" | lolcat 
else
	echo -n "$@"
fi
