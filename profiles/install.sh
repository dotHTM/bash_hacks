#!/bin/bash
#
#

profileDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ~/

if [[ ! -e .profile.bak && ! -e .bash_profile.bak ]]; then

	mv .profile .profile.bak
	mv .bash_profile .bash_profile.bak

	touch .bashrc
	ln .bashrc .profile
	ln .bashrc .bash_profile

	echo "## Bash hacks profile
  # export PrivateBASHRCPath=\$HOME/Documents/config/private_profile
	# source $profileDir/bashrc.bash
  " >> ~/.bashrc

	echo "It would be a good idea to look at your .bashrc file and verify it's contents"

else
	echo "
Have you already run this installer?
You have backups you may want to compare/cleanup before proceeding.
"
fi
