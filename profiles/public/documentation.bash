

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

read_help(){
    my_filename=$1 && shift
    
    while read line ; do
        if [[ "$line" =~ "#help=" || "$line" =~ "#args=" ]]; then
            
            my_id="$line"
            my_id=${my_id/*alias }
            my_id=${my_id/*function }
            my_id=${my_id/()*}
            my_id=${my_id/=*}
            
            my_args=''
            
            if [[ "$line" =~ "#args=" ]]; then
                my_args="$line"
                my_args=${my_args/*#args=}
                my_args=${my_args/\#*}
            fi
            
            my_help=''
            
            if [[ "$line" =~ "#help=" ]]; then
                my_help="$line"
                my_help=${my_help/*#help=}
            fi
            
            display_help_line "$my_id" "$my_args" "$my_help"
        fi
    done <<< `cat "${my_filename}"`
}

display_help_line(){
    identifier=$1 && shift
    argument_string=$1 && shift
    descrtiption_string=$1 && shift
    
    extra_bit=6
    
    echo -n "${indent}${identifier}"
    if [[ -n $argument_string ]]; then
        space_to_length 1
        echo $argument_string
        space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH ))
    elif (( ${#identifier} > $HELP_MAX_NAME_LENGTH )); then
        echo
        space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH ))
    else
        space_to_length $(( $HELP_MAX_NAME_LENGTH - ${#identifier} ))
    fi
    space_to_length 3
    
    first_run_done=0
    
    column_width=$(( `tput cols` - $HELP_INDENT_LENGTH - $HELP_MAX_NAME_LENGTH - $extra_bit ))
    for (( start_point = 0; start_point < ${#descrtiption_string}; start_point+=${column_width} )); do
        if [[ "$first_run_done" == "1" ]]; then
            echo "…"
            space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH + $extra_bit ))
            echo -n "…"
        else
            echo -n "-"
            first_run_done=1
        fi
        echo -n "${descrtiption_string:$start_point:$column_width}"
        
    done
    echo
    
    

}


get_help(){

    read_help "$PROFILE_DIR/public/alias.bash"
    
    # read_alias_help "$PROFILE_DIR/public/alias.bash"
    # read_functions_help "$PROFILE_DIR/public/alias.bash"


}


