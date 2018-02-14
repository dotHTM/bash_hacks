#!/bin/bash
#
#

BH_PROFILE_DIR=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

cd ~/

if [[ 
	! -e .bashrc.bak && 
! -e .bash_profile.bak && 
! -e .profile.bak
]]; then

	mv .bashrc .bashrc.bak
	mv .bash_profile .bash_profile.bak
	mv .profile .profile.bak

	touch .bashrc
	ln .bashrc .profile
	ln .bashrc .bash_profile

	echo '


####################################
###### Bash hacks profile
export BH_PROFILE_DIR=/Users/dothtm/Developer/bash_hacks/profiles

#### If you have a private profile on disk or cloud service.
export BH_PRIVATE_BASHRC_PATH=$HOME/Documents/config/private_profile

#### If your hostname is goofed up by DNS, etc and you are
##   bothered by that thing. Or if you want emoji or 
##   something custom in your hostname.
# export BH_VANITY_HOSTNAME=`hostname`" 🌈🖥  "

#### Enable bh_profile
# source $BH_PROFILE_DIR/bashrc.bash

#### Your desired prompt
# boldPrompt

######
####################################

' >> ~/.bashrc

	echo "
The installation is not done.

It would be a good idea to look at your .bashrc file and verify it's contents
"


else
	echo "
Have you already run this installer?
You have backups you may want to compare/cleanup before proceeding.
	"
fi
