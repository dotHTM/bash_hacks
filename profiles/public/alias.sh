#!/bin/bash
#
# 


# - Lazy
alias portprep="xcode-select --install; sudo xcodebuild -license"

alias qbashedit="nano ~/.bashrc"
alias sbashedit="subl ~/.bashrc --project $baseDir/../bash_hacks.sublime-project"
alias duh="du -h -d 1"
alias lsa="ls -lha"
alias lsaf="clear; lsa; ls -la *"
# alias twopen="open -a /Applications/BBedit.app/ "
alias qlynx="cd ~/Downloads/; lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies; rm /tmp/lynxcookie"
alias primedocker="/Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh"

# Quick way to rebuild the Launch Services database and get rid of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

