#!/usr/bin/env bash
# insomnia.sh



time_to(){
    hour=$1 && shift
    minute=$1 && shift
    next_day=$1 && shift
    
    if [[ -z $next_day ]]; then
        echo $(( `date -v${hour}H -v${minute}M -v0S "+%s"` - `date "+%s"` ))
    else
        echo $(( `date -v${hour}H -v${minute}M -v0S -v+${next_day}d "+%s"` - `date "+%s"` ))
    fi
}

buzz_until(){
    hour=$1 && shift
    minute=$1 && shift
    next_day=$1 && shift
    caffeinate -disu -t $( time_to $hour $minute $next_day )
}

buzzed_durring(){
    start_hour=$1 && shift
    start_minute=$1 && shift

    end_hour=$1 && shift
    end_minute=$1 && shift
    end_next_day=$1 && shift
    
    start_delta=$( time_to $start_hour $start_minute )
    end_delta=$( time_to $end_hour $end_minute $end_next_day )
    
    if (( $start_delta < 0 && 0 < $end_delta )); then 
        buzz_until ${end_hour} ${end_minute} ${end_next_day}
    else
        sleep 30
    fi
}

while [[ 1 == 1 ]]; do
    buzzed_durring 08 00 12 00
    buzzed_durring 13 00 17 00
done
