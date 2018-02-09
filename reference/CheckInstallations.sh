#!/usr/local/bin/bash

# Mac Port Prep

port selfupdate
port upgrade outdated

	# Installations
	
	port install imagesnap
	port install screen
	port install wget

# Other Command installations

gem install lolcat
