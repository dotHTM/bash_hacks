#!/bin/bash
#
# 


# Lazy commands

alias rcreload="source ~/.bashrc"
alias qbashedit="nano ~/.bashrc"
alias xcprep="xcode-select --install; sudo xcodebuild -license"

alias duh="du -h -d 1"
alias lsa="ls -lha"
alias lsaf="clear; lsa; ls -la *"

alias qlynx="cd ~/Downloads/; lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies; rm /tmp/lynxcookie"

# Sublime Text Helpers
alias sbashedit="subl ~/.bashrc --project $baseDir/../bash_hacks.sublime-project"

alias subproj="subl --project *.sublime-project"
alias shost="subl -n /etc/hosts"



# Date fun
alias dateiso="date \"+%Y%m%d\""
alias timeiso="date \"+%Y%m%d-%H%M%S\""


# Note taking

alias fhist="history > `date '+%Y%m%d_%s'`.hist.$USER.txt"



