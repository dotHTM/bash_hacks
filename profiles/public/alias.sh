#!/bin/bash
#
# 


### Lazy commands

alias rcreload="source ~/.bashrc"
alias qbashedit="nano ~/.bashrc"
alias xcprep="xcode-select --install && sudo xcodebuild -license"

alias duh="du -h -d 1"
alias ll="ls -lh"
alias lsa="ls -lha"
alias lsaf="clear; lsa; ls -la *"

alias qlynx="cd ~/Downloads/ && lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies && rm /tmp/lynxcookie"

### Sublime Text Helpers

alias sbashedit="subl ~/.bashrc --project $baseDir/../bash_hacks.sublime-project"
alias shost="subl -n /etc/hosts"

## Open a Sublime Text project file here or at some path
#   subproj [../path/that/contains/a/project/]
subproj() {
	myPath="."
	if [[ -n $1 ]]; then
		myPath=$1 && shift
	fi
	
	foundProjects=`find ${myPath} -d 1 -iname "*.sublime-project"`
	
	if [[ -z $foundProjects ]]; then
		echo "No files found for filter '*.sublime-project'"
	else
		subl --project ${myPath}/*.sublime-project
	fi
}

### Date fun
alias dateiso="date \"+%Y%m%d\""
alias timeiso="date \"+%Y%m%d-%H%M%S\""

### Note taking

alias fhist="history > `date '+%Y%m%d_%s'`.hist.$USER.txt"



