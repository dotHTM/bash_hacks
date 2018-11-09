#!/bin/bash
#
#

BH_PROFILE_DIR=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

cd ~/

#if [[ 
#	! -e .bashrc.bak && 
#	! -e .bash_profile.bak && 
#	! -e .profile.bak
#	]]; then

	mv .bashrc .bashrc.bak
	mv .bash_profile .bash_profile.bak
	mv .profile .profile.bak

	touch .bashrc
	ln .bashrc .profile
	ln .bashrc .bash_profile

	echo " 


####################################
###### Bash hacks profile
export BH_PROFILE_DIR=\"$BH_PROFILE_DIR\"

#### If you have a private profile on disk or cloud service.
export BH_PRIVATE_BASHRC_PATH=\"$HOME/Documents/config/private_profile\"

#### If your hostname is goofed up by DNS, or if you want emoji or 
##   something custom in your hostname.
# export BH_VANITY_HOSTNAME=\"`hostname` :)\"

#### Enable bh_profile
source \"$BH_PROFILE_DIR/bashrc.bash\"
alias get_help=\"search_multiple_dir_for_help '$BH_PROFILE_DIR/public/' '\${BH_PRIVATE_BASHRC_PATH}'\"


#### Your desired prompt
color_setup
boldPrompt

######
####################################

" >> ~/.bashrc

	echo "
The installation is not done.

It would be a good idea to look at your .bashrc file and verify it's contents
"

#else
#	echo "
#Have you already run this installer?
#You have backups you may want to compare/cleanup before proceeding.
#	"
#fi

ln -s "$HOME/Library/Application Support/Sublime Text 3/Packages/User" "$HOME/.subl_prefs"
