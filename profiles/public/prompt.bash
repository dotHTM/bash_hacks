#!/bin/bash
# prompt.sh


plainPrompt(){
    export PS1="[ \u @ \h : \W ] \! > "
}

escape_wrap(){
    echo "\[$1\]"
}

## Color shortcuts
if [[ -n $PS1 ]]; then
    tput init
    
    ## Raw values
    tput_bold=`tput bold`
    tput_undl=`tput smul`
    tput_revE=`tput rev`
    tput_blnk=`tput blink`
    tput_nrml=`tput sgr0`
    tput_theme1color=`tput setaf 1`
    tput_theme2color=`tput setaf 2`
    tput_theme3color=`tput setaf 3`
    tput_theme4color=`tput setaf 6`

    ## Wrapped values for PS1
    wrapped_tput_bold=`escape_wrap $tput_bold`
    wrapped_tput_undl=`escape_wrap $tput_undl`
    wrapped_tput_revE=`escape_wrap $tput_revE`
    wrapped_tput_blnk=`escape_wrap $tput_blnk`
    wrapped_tput_nrml=`escape_wrap $tput_nrml`
    wrapped_tput_theme1color=`escape_wrap $tput_theme1color`
    wrapped_tput_theme2color=`escape_wrap $tput_theme2color`
    wrapped_tput_theme3color=`escape_wrap $tput_theme3color`
    wrapped_tput_theme4color=`escape_wrap $tput_theme4color`
    
    ## HR
    term_width=`tput cols`
    for (( i = 0; i < $term_width; i++ )); do
        echo -n "="
    done
    
    ## Display a message the terminal is Interactive and if Screen
    echo -n "  ${tput_theme1color}>>${tput_nrml} ${tput_theme2color}Interactive Shell${tput_nrml} : ${tput_theme4color}Lvl ${SHLVL}${tput_nrml} ${tput_theme1color}<<${tput_nrml}  "
    if [[ "$TERM" == "screen" ]]; then
        echo -n "  ${tput_theme1color}>>${tput_nrml} ${tput_theme3color}Screen${tput_nrml} ${tput_theme1color}<<${tput_nrml}  "
    fi
    echo
fi ## /Color shortcuts

# export PS1="[ ${bold}\u${nrml} @ ${undl}${bold}\h${nrml} : ${bold}\W${nrml} ]"

# export PS1="    ${bold}[${nrml} \u ${bold}@${nrml} ${undl}\h${nrml} ${bold}:${nrml} \W ${bold}]${nrml}\n  ${bold}>${nrml} "


if [[ -n $VANITY_HOSTNAME ]]; then bashHostNameReplacement=$VANITY_HOSTNAME
else bashHostNameReplacement="\h"
fi

commandLineDeliminator=" "

change_PS1(){
    myInputString="$1"
    if [[ -n $PS1 ]]; then
        export PS1="$myInputString"
    fi
}

dullPrompt(){
    change_PS1 "[ \u @ ${bashHostNameReplacement} : \W ]${commandLineDeliminator}\! > "
}

boldPrompt(){
    change_PS1 "${wrapped_tput_theme1color}${wrapped_tput_bold}[${wrapped_tput_nrml} ${wrapped_tput_theme3color}\u${wrapped_tput_nrml} ${wrapped_tput_theme1color}${wrapped_tput_bold}@${wrapped_tput_nrml} ${wrapped_tput_theme4color}${wrapped_tput_undl}${bashHostNameReplacement}${wrapped_tput_nrml} ${wrapped_tput_theme1color}${wrapped_tput_bold}:${wrapped_tput_nrml} \W ${wrapped_tput_theme1color}${wrapped_tput_bold}]${wrapped_tput_nrml}${commandLineDeliminator}${wrapped_tput_theme2color}${wrapped_tput_bold}\! >${wrapped_tput_nrml} "
}

shortPrompt(){
    change_PS1 "${wrapped_tput_theme1color}${wrapped_tput_bold}[${wrapped_tput_nrml} ${wrapped_tput_theme1color}${wrapped_tput_bold}:${wrapped_tput_nrml} \W ${wrapped_tput_theme1color}${wrapped_tput_bold}]${wrapped_tput_nrml}${commandLineDeliminator}${wrapped_tput_theme2color}${wrapped_tput_bold}\! >${wrapped_tput_nrml} "
}

