#!/bin/bash
#
# 

# git Stuff

if [ -f ./plugins/.git-completion.bash ]; then
	source ./plugins/.git-completion.bash
fi
# if [ -f ~/.git-prompt.sh ]; then
# 	source ~/.git-prompt.sh
# 	PS1="[ \u @ \h : \W$(__git_ps1) ]"
# fi