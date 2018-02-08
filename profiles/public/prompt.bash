#!/bin/bash
# prompt.sh


plainPrompt(){
    export PS1="[ \u @ \h : \W ] \! > "
}

escape_wrap(){
    echo "\[$1\]"
}

##### THIS IS A HECKIN MESS!!!!

## Color shortcuts
if [[ -n $PS1 ]]; then
    tput init
    
    theme_1=196
    theme_2=46
    theme_3=208
    theme_4=226
    
    ## Raw values
    tput_bold=`tput bold`
    tput_undl=`tput smul`
    tput_revE=`tput rev`
    tput_blnk=`tput blink`
    tput_nrml=`tput sgr0`
    tput_theme1color=`tput setaf ${theme_1}`
    tput_theme2color=`tput setaf ${theme_2}`
    tput_theme3color=`tput setaf ${theme_3}`
    tput_theme4color=`tput setaf ${theme_4}`

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
    
    bracket_color="${tput_theme1color}${tput_bold}"
    user_color="${tput_theme3color}"
    hostname_color="${tput_theme4color}${tput_undl}"
    prompt_color="${tput_theme2color}${tput_bold}"
    reset_color="${tput_nrml}"
    
    wr_bracket_color=`escape_wrap ${bracket_color}`
    wr_user_color=`escape_wrap ${user_color}`
    wr_hostname_color=`escape_wrap ${hostname_color}`
    wr_prompt_color=`escape_wrap ${prompt_color}`
    wr_reset_color=`escape_wrap ${reset_color}`
    
    theme_info(){
        echo " ${tput_theme1color}tput_theme1color${tput_nrml} = ${theme_1}"
        echo " ${tput_theme2color}tput_theme2color${tput_nrml} = ${theme_2}"
        echo " ${tput_theme3color}tput_theme3color${tput_nrml} = ${theme_3}"
        echo " ${tput_theme4color}tput_theme4color${tput_nrml} = ${theme_4}"
        echo ""
        echo " ${bracket_color}bracket_color ${tput_nrml} = ${theme_1}"
        echo " ${user_color}user_color    ${tput_nrml} = ${theme_2}"
        echo " ${hostname_color}hostname_color${tput_nrml} = ${theme_3}"
        echo " ${prompt_color}prompt_color  ${tput_nrml} = ${theme_4}"
    }
    
    
    ## HR
    term_width=`tput cols`
    for (( i = 0; i < $term_width; i++ )); do
        echo -n "="
    done
    
    ## Display a message the terminal is Interactive and if Screen
    echo -n "  ${bracket_color}>>${tput_nrml} ${user_color}Interactive Shell${tput_nrml} : ${hostname_color}Lvl ${SHLVL}${tput_nrml} ${bracket_color}<<${tput_nrml}  "
    if [[ "$TERM" == "screen" ]]; then
        echo -n "  ${bracket_color}>>${tput_nrml} ${prompt_color}Screen${tput_nrml} ${bracket_color}<<${tput_nrml}  "
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
    change_PS1 "${wr_bracket_color}[${wr_reset_color} ${wr_user_color}\u${wr_reset_color} ${wr_bracket_color}@${wr_reset_color} ${wr_hostname_color}${bashHostNameReplacement}${wr_reset_color} ${wr_bracket_color}:${wr_reset_color} \W ${wr_bracket_color}]${wr_reset_color}${commandLineDeliminator}${wr_prompt_color}\! >${wr_reset_color} "
}

shortPrompt(){
    change_PS1 "${wr_bracket_color}[${wr_reset_color} ${wr_bracket_color}:${wr_reset_color} \W ${wr_bracket_color}]${wr_reset_color}${commandLineDeliminator}${wr_prompt_color}\! >${wr_reset_color} "
}

