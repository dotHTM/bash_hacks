#!/bin/bash
#
# 

export PS1="	[ \u @ \h : \W ]"


tput init
bold="\[`tput bold`\]"
undl="\[`tput smul`\]"
revE="\[`tput rev`\]"
blnk="\[`tput blink`\]"
nrml="\[`tput sgr0`\]"

# export PS1="[ ${bold}\u${nrml} @ ${undl}${bold}\h${nrml} : ${bold}\W${nrml} ]"

export PS1="    ${bold}[${nrml} \u ${bold}@${nrml} ${undl}\h${nrml} ${bold}:${nrml} \W ${bold}]${nrml}\n  ${bold}>${nrml} "


