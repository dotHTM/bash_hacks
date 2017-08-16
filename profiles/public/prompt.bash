#!/bin/bash
# prompt.sh

export PS1="	[ \u @ \h : \W ]"

tput init
tput_bold="\[`tput bold`\]"
tput_undl="\[`tput smul`\]"
tput_revE="\[`tput rev`\]"
tput_blnk="\[`tput blink`\]"
tput_nrml="\[`tput sgr0`\]"

tput_theme1color="\[`tput setaf 1`\]"
tput_theme2color="\[`tput setaf 2`\]"
tput_theme3color="\[`tput setaf 3`\]"
# tput_plaincolor="\[`tput setaf 7`\]"


# export PS1="[ ${bold}\u${nrml} @ ${undl}${bold}\h${nrml} : ${bold}\W${nrml} ]"

# export PS1="    ${bold}[${nrml} \u ${bold}@${nrml} ${undl}\h${nrml} ${bold}:${nrml} \W ${bold}]${nrml}\n  ${bold}>${nrml} "


newlineSeperator=""

boldPrompt(){
	tput init
	export PS1="${tput_theme1color}${tput_bold}[${tput_nrml} ${tput_theme3color}\u${tput_nrml} ${tput_theme1color}${tput_bold}@${tput_nrml} ${tput_theme3color}${tput_undl}\h${tput_nrml} ${tput_theme1color}${tput_bold}:${tput_nrml} \W ${tput_theme1color}${tput_bold}]${tput_nrml}${newlineSeperator} ${tput_theme2color}${tput_bold}>${tput_nrml} "
}

boldPrompt