#!/bin/bash
#
# 


if [[ -e "/opt/local/bin/port" ]]; then
	echo
	echo "==== port ===="
	sudo /opt/local/bin/port selfupdate
	sudo /opt/local/bin/port upgrade outdated
fi

if [[ -e "/usr/local/bin/brew" ]]; then
	echo
	echo "==== brew ===="
	/usr/local/bin/brew update
	/usr/local/bin/brew upgrade
fi

if [[ -e "/usr/local/bin/gem" ]]; then
	echo
	echo "==== gem ===="
	/usr/local/bin/gem update --system
	/usr/local/bin/gem update
fi

if [[ -e "/usr/local/bin/npm" ]]; then
	echo
	echo "==== npm ===="
	/usr/local/bin/npm update -g
fi

echo
echo "==== apple ===="
/usr/sbin/softwareupdate -i -a


echo



