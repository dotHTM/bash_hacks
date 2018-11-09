# prompt.sh


prompt_user="$USER"
export PROMPT_STYLE=''

# hr_echo "=" 32
# hr_echo "="
hr_echo(){
    declare string_segment='-'
    if [[ -n $1 ]]; then
        string_segment=$1 && shift
    fi
    
    declare hr_length=$1 && shift
    if [[ "$hr_length" == 0 || -z $hr_length ]]; then
        hr_length=`tput cols`
    fi
    declare hr_string=""
    declare next_hr_len=$((${#hr_string}+${#string_segment}))
    while [[ "$next_hr_len" -le "$hr_length" ]]; do
        hr_string="${hr_string}${string_segment}"
        next_hr_len=$(( ${#hr_string} + ${#string_segment} ))
    done
    echo "$hr_string"
}

plainPrompt(){
    export PS1="[ \u @ \h : \W ] \! > "
}

escape_wrap(){
    echo "\[$1\]"
}

color_setup(){
    ## Color shortcuts
    if [[ -n $TERM || -n $PS1 ]]; then
        tput init

        style_black=`tput setaf 0`
        style_red=`tput setaf 1`
        style_green=`tput setaf 2`
        style_yellow=`tput setaf 3`
        style_blue=`tput setaf 4`
        style_violet=`tput setaf 5`
        style_cyan=`tput setaf 6`
        style_white=`tput setaf 7`

        style_black_bold=`tput setaf 8`
        style_red_bold=`tput setaf 9`
        style_green_bold=`tput setaf 10`
        style_yellow_bold=`tput setaf 11`
        style_blue_bold=`tput setaf 12`
        style_violet_bold=`tput setaf 13`
        style_cyan_bold=`tput setaf 14`
        style_white_bold=`tput setaf 15`

        ## Raw values
        style_bold=`tput bold`
        style_undl=`tput smul`
        style_revE=`tput rev`
        style_blnk=`tput blink`
        style_nrml=`tput sgr0`
        style_theme1color=$style_red  #brackets
        style_theme2color=$style_green  #carrot
        style_theme3color=$style_blue  #user
        style_theme4color=$style_yellow  #hostname

        ## Wrapped values for PS1
        wrapped_style_bold=`escape_wrap $style_bold`
        wrapped_style_undl=`escape_wrap $style_undl`
        wrapped_style_revE=`escape_wrap $style_revE`
        wrapped_style_blnk=`escape_wrap $style_blnk`
        wrapped_style_nrml=`escape_wrap $style_nrml`
        wrapped_style_theme1color=`escape_wrap $style_theme1color`
        wrapped_style_theme2color=`escape_wrap $style_theme2color`
        wrapped_style_theme3color=`escape_wrap $style_theme3color`
        wrapped_style_theme4color=`escape_wrap $style_theme4color`

        bracket_color="${style_theme1color}${style_bold}"
        user_color="${style_theme3color}"
        hostname_color="${style_theme4color}${style_undl}"
        prompt_color="${style_theme2color}${style_bold}"
        reset_color="${style_nrml}"

        wr_bracket_color="${wrapped_style_theme1color}${wrapped_style_bold}"
        wr_user_color="${wrapped_style_theme3color}"
        wr_hostname_color="${wrapped_style_theme4color}${wrapped_style_undl}"
        wr_prompt_color="${wrapped_style_theme2color}${wrapped_style_bold}"
        wr_reset_color="${wrapped_style_nrml}"
    fi
}

theme_info(){
    echo " ${style_theme1color}style_theme1color${style_nrml}"
    echo " ${style_theme2color}style_theme2color${style_nrml}"
    echo " ${style_theme3color}style_theme3color${style_nrml}"
    echo " ${style_theme4color}style_theme4color${style_nrml}"
    echo ""
    echo " ${bracket_color}bracket_color ${style_nrml}"
    echo " ${user_color}user_color    ${style_nrml}"
    echo " ${hostname_color}hostname_color${style_nrml}"
    echo " ${prompt_color}prompt_color  ${style_nrml}"
}


interactive_message(){
    ## HR
    hr_echo "="
    ## Display a message the terminal is Interactive and if Screen
    echo -n "  ${bracket_color}>>${style_nrml} ${user_color}Interactive Shell${style_nrml} : ${hostname_color}Lvl ${SHLVL}${style_nrml} ${bracket_color}<<${style_nrml}  "
    if [[ "$TERM" == "screen" ]]; then
        echo -n "  ${bracket_color}>>${style_nrml} ${prompt_color}Screen${style_nrml} ${bracket_color}<<${style_nrml}  "
    fi
    echo
}

if [[ -n $BH_VANITY_HOSTNAME ]]; then
    bashHostNameReplacement=$BH_VANITY_HOSTNAME
else
    bashHostNameReplacement="\h"
fi

commandLineDeliminator=" "


change_PS1(){
    export PROMPT_STYLE="$1" && shift
    myInputString="$1" 
    if [[ -n $PS1 ]]; then
        export PS1="$myInputString"
    fi
}

dullPrompt(){
    change_PS1 dullPrompt "[ $prompt_user @ ${bashHostNameReplacement} : \W ]${commandLineDeliminator}\! > "
}

boldPrompt(){
    change_PS1 boldPrompt "${wr_bracket_color}[${wr_reset_color} ${wr_user_color}$prompt_user${wr_reset_color} ${wr_bracket_color}@${wr_reset_color} ${wr_hostname_color}${bashHostNameReplacement}${wr_reset_color} ${wr_bracket_color}:${wr_reset_color} \W ${wr_bracket_color}]${wr_reset_color}${commandLineDeliminator}${wr_prompt_color}\! >${wr_reset_color} "
}

shortPrompt(){
    change_PS1 shortPrompt "${wr_bracket_color}[${wr_reset_color} ${wr_bracket_color}:${wr_reset_color} \W ${wr_bracket_color}]${wr_reset_color}${commandLineDeliminator}${wr_prompt_color}\! >${wr_reset_color} "
}

reprompt(){
    $PROMPT_STYLE
}

cosplay(){
    prompt_user="$1" && shift
    if [[ -n $1 ]]; then
        bashHostNameReplacement="$1" && shift
    fi
    reprompt
}
