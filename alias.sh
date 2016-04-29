#!/bin/bash
#

#Alias stuff because I'm lazy

alias portprep="xcode-select --install; sudo xcodebuild -license"

alias qbashedit="nano ~/.bashrc"
alias sbashedit="subl ~/.bashrc"

alias duh="du -h -d 1"
alias lsa="ls -lha"
alias lsaf="clear; lsa; ls -la *"

# alias twopen="open -a /Applications/BBedit.app/ "  # I don't use Text Wrangler or BBEdit anymore, Sublime Text is my Text Editor of choice
alias qlynx="cd ~/Downloads/; lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies; rm /tmp/lynxcookie"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
