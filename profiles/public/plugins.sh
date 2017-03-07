#!/bin/bash
#
# 



# updates
shell_update_plugins(){
	mkdir -p $profileDir/plugins
	cd $profileDir/plugins
	curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
}



# git Stuff

if [ -f $profileDir/plugins/git-completion.bash ]; then
	source $profileDir/plugins/git-completion.bash
fi
# if [ -f ~/.git-prompt.sh ]; then
# 	source ~/.git-prompt.sh
# 	PS1="[ \u @ \h : \W$(__git_ps1) ]"
# fi


# # bash completion
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
