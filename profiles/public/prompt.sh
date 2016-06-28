#!/bin/bash
#
# 

tput init
bold="\[`tput bold`\]"
undl="\[`tput smul`\]"
revE="\[`tput rev`\]"
blnk="\[`tput blink`\]"
nrml="\[`tput sgr0`\]"

export PS1="[ ${bold}\u${nrml} @ ${undl}${bold}\h${nrml} : ${bold}\W${nrml} ]"

