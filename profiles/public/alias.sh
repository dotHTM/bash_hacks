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

playground(){
	testDir="${HOME}/priv/test/"
	cd $testDir
	mkdir -p ${testDir}
	subl ${testDir}
}

# Git 

alias gdiff="git difftool"
alias gstat="git status"
alias gadd="git add"

# Logs

alias glbranch="git log --graph --oneline --all --decorate"
alias glstat="git log --stat -5"


# Sublime Text Helpers

alias sbashedit="subl ~/.bashrc --project $profileDir/../bash_hacks.sublime-project"
alias smlcedit="subl ~/.bashrc --project $profileDir/../../machete-line-commands/machete-line-commands.sublime-project"
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

### Useful functions

looping(){
	timeToWait=$1 && shift
	commandToExec=$1 && shift
	
	while :; do
		$commandToExec
		sleep $timeToWait
	done
}


## Save the results of a command to a variable, and save it so it can be recalled later

tmpCache=""
cacheCommand(){
	inputCommand="$*"
	tmpCache=`$inputCommand`
	echo $tmpCache
}

alias ccmd="cacheCommand"
alias ecmd="echo \$tmpCache"

## Search a file(s)
# searchFile [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"]
searchFile() {
	if [[ $1 == "-d" ]]; then
		shift
		debug=true
	fi
	inputPath=$1 && shift
	grepString=$1 && shift
	additionalString=$1 && shift
	
	if [[ -n $additionalString ]]; then
		highlightString="(${grepString}|${additionalString})"
	else
		highlightString="(${grepString})"
	fi
	highlightString=`echo ${highlightString} | perl -pe "s/\\//\\\\\\\\\//gi"`
	perlString="s/(`echo ${highlightString}`)/`tput setaf 1`\1`tput sgr0`/gi"
	
	if [[ $debug ]]; then
		echo "inputPath       = "$inputPath
		echo "grepString      = "$grepString
		echo "perlString      = "$perlString
		echo "highlightString = "$highlightString
		echo "---- ---- ---- ---- ---- ---- ---- ---- "
	fi
	cat $inputPath | grep -E "$grepString" | perl -pe "$perlString"
}
