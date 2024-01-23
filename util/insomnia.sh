#!/usr/bin/env bash
# insomnia.sh


time_to(){
    message=$1 && shift
    hour=$1 && shift
    minute=$1 && shift
    next_day=$1 && shift
    
    if [[ -z $minute ]]; then
        until="${message} ${hour}"
        minute="00"
    else
        until="${message} ${hour}:${minute}"
    fi
    
    mkdir -p ~/.config/variables
    echo "${until}" > ~/.config/variables/insomnia.txt
    
    if [[ -z $next_day ]]; then
        echo $(( `date -v${hour}H -v${minute}M -v0S "+%s"` - `date "+%s"` ))
    else
        echo $(( `date -v${hour}H -v${minute}M -v0S -v+${next_day}d "+%s"` - `date "+%s"` ))
    fi
}

wait_until(){
    hour=$1 && shift
    minute=$1 && shift
    next_day=$1 && shift
    sleep $( time_to "" $hour $minute $next_day )
}
buzz_until(){
    hour=$1 && shift
    minute=$1 && shift
    next_day=$1 && shift
    caffeinate -disu -t $( time_to "☕️" $hour $minute $next_day )
}

wait_until 8
buzz_until 12
wait_until 13
buzz_until 17
wait_until "00" "00" 1
