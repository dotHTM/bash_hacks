

if [[ -z $HELP_MAX_NAME_LENGTH ]]; then
    HELP_MAX_NAME_LENGTH=12
fi


space_to_length(){
    my_length=$1
    if (( $my_length > 0 )); then
        for i in `seq $my_length`; do
            echo -n " "
        done
    fi
}

HELP_INDENT_LENGTH=4
indent=`space_to_length ${HELP_INDENT_LENGTH}`
description_deliminator=" - "

description_wrap_indent=`space_to_length $(( $HELP_MAX_NAME_LENGTH + ${#description_deliminator} ))`

declare -A help_dict

read_alias_help(){
    my_filename=$1 && shift
    
    while read line ; do
        my_alias=${line/=*}
        my_alias=${my_alias/alias }
        my_help=${line/*#help= }
        my_args=${my_help/ => *}
        if [[ "$my_help" == "$my_args" ]]; then
            my_args=""
        else
            my_help=${my_help/* => }
            my_args="${my_args}
            ${indent}${description_wrap_indent}"
        fi
        display_help_line "$my_alias" "$my_args" "$my_help"
    done <<< `cat "${my_filename}" | grep -e "^\s*alias\s" | grep "#help= "`
    
    # display_help
}


read_functions_help(){
    my_filename=$1 && shift
    
    while read line ; do
        my_func=${line/()*}
        my_func=${my_func/* }
        my_func="${my_func}()"
        my_help=${line/*#help= }
        my_args=${my_help/ => *}
        if [[ "$my_help" == "$my_args" ]]; then
            my_args=""
        else
            my_help=${my_help/* => }
            my_args="${my_args}
            ${indent}${description_wrap_indent}"
        fi
        display_help_line "$my_func" "$my_args" "$my_help"
    done <<< `cat "${my_filename}" | grep -e "^\s*.*(\s*)\s*{"| grep "#help= "`


    
    # display_help
}

display_help_line(){
    identifier=$1 && shift
    argument_string=$1 && shift
    descrtiption_string=$1 && shift
    
    extra_bit=6
    
    
    echo -n "${indent}${identifier}"
    if [[ -n $argument_string ]]; then
        space_to_length 2
        echo $argument_string
        space_to_length $HELP_MAX_NAME_LENGTH
    elif (( ${#identifier} > $HELP_MAX_NAME_LENGTH )); then
        echo
        space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH ))
        extra_bit=10
    else
        space_to_length $(( $HELP_MAX_NAME_LENGTH - ${#identifier} ))
    fi
    space_to_length 2
    
    first_run_done=0
    
    
    
    
    column_width=$(( `tput cols` - $HELP_INDENT_LENGTH - $HELP_MAX_NAME_LENGTH - $extra_bit ))
    for (( start_point = 0; start_point < ${#descrtiption_string}; start_point+=${column_width} )); do
        if [[ "$first_run_done" == "1" ]]; then
            echo -n "…"
            space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH + $extra_bit ))
        else
            first_run_done=1
        fi
        echo -n "${descrtiption_string:$start_point:$column_width}"
    done
    echo
    
    

}


get_help(){

    read_alias_help "$PROFILE_DIR/public/alias.bash"
    read_functions_help "$PROFILE_DIR/public/alias.bash"


}



