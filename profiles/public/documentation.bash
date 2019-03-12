
if [[ $IS_USER_TERM == 1 ]]; then

if [[ -z $HELP_MAX_NAME_LENGTH ]]; then
    HELP_MAX_NAME_LENGTH=12
fi





left_wrap_align_bit=3
right_wrap_margin_bit=6

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
    
    tput_bold=`tput bold`
    tput_undl=`tput smul`
    tput_revE=`tput rev`
    tput_blnk=`tput blink`
    tput_nrml=`tput sgr0`

    color_directory=`tput setaf 9`
    color_file=`tput setaf 10`
    color_identifier=`tput setaf 14`
    color_arguments=`tput setaf 11`
    
    has_help=0
    need_to_print_filename=1
    
    while my_filename=$1 && shift; do
      
        while read line ; do
            if [[ "$line" =~ " ""#help=" || "$line" =~ " ""#args=" ]]; then
                # the use of quotes 
                
                my_id="$line"
                my_id=${my_id/*alias }
                my_id=${my_id/*function }
                my_id=${my_id/()*}
                my_id=${my_id/=*}
                
                my_args=''
                
                if [[ "$line" =~ "#args=" ]]; then
                    my_args="$line"
                    my_args=${my_args/*#args= }
                    my_args=${my_args/*#args=}
                    my_args=${my_args/\#*}
                fi
                
                my_help=''
                
                if [[ "$line" =~ "#help=" ]]; then
                    my_help="$line"
                    my_help=${my_help/*#help= }
                    my_help=${my_help/*#help=}
                fi
                
                
                if [[ $my_args || $my_help  ]]; then
                    has_help=1
                fi
                
                
                if [[ $has_help && $need_to_print_filename ]]; then
                    echo
                    echo "${color_file}### ${my_filename} ###${tput_nrml}"
                    echo
                    need_to_print_filename=''
                fi
                
                display_help_line "$my_id" "$my_args" "$my_help"
            fi
        done <<< `cat "${my_filename}"`
    done
}

display_help_line(){
    identifier=$1 && shift
    argument_string=$1 && shift
    descrtiption_string=$1 && shift
    
    if (( ${#identifier} <= $HELP_MAX_NAME_LENGTH )); then
        space_to_length $(( $HELP_MAX_NAME_LENGTH - ${#identifier} ))
    fi
    echo -n "${indent}${tput_bold}${color_identifier}${identifier}${tput_nrml}"
    if [[ -n $argument_string ]]; then
        space_to_length 1
        echo "${color_arguments}${argument_string}${tput_nrml}"
        space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH ))
    elif (( ${#identifier} > $HELP_MAX_NAME_LENGTH )); then
        echo
        space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH ))
    fi
    echo -n "${tput_nrml}"
    space_to_length 1
    
    first_run_done=0
    
    column_width=$(( `tput cols` - $HELP_INDENT_LENGTH - $HELP_MAX_NAME_LENGTH - $right_wrap_margin_bit ))
    for (( start_point = 0; start_point < ${#descrtiption_string}; start_point+=${column_width} )); do
        if [[ "$first_run_done" == "1" ]]; then
            echo "…"
            space_to_length $(( $HELP_INDENT_LENGTH + $HELP_MAX_NAME_LENGTH + $left_wrap_align_bit ))
            echo -n "…"
        else
            echo -n "- "
            first_run_done=1
        fi
        echo -n "${descrtiption_string:$start_point:$column_width}"
        
    done
    echo
    
}


search_multiple_dir_for_help(){
    directory_list=($*)
    element_count=${#directory_list[*]}
    for i in `seq 0 $(($element_count-1))` ; do
        echo
        echo "${color_directory}### ${directory_list[$i]} ###${tput_nrml}"
        search_dir_for_help ${directory_list[$i]}
    done
}



search_dir_for_help(){
    for some_file in `find "$1" -iname "*.bash"`; do
        read_help $some_file
    done
}


fi