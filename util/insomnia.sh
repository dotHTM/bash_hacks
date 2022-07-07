#!/usr/bin/env bash
# insomnia.sh


echo "################################"
date


while [[ 1 == 1 ]]; do

    # echo  "lunch time"

    now=`date "+%s"`
    nextSleep=`date -v11H -v30M "+%s"`
    declare -i delta=${nextSleep}-${now}-60
    if [[ -z ${delta/0-9//} ]]; then
        # echo "delta     $delta"
        # echo "now       $now"
        # echo "nextSleep $nextSleep"
        date -v+${delta}S
        echo $delta
        if [[ $delta -gt 0 ]]; then
            caffeinate -disu -t $delta
        fi
        sleep 3600
    fi
    
    # echo  "end of the work day"
    
    now=`date "+%s"`
    
    nextSleep=`date -v16H -v30M "+%s"`
    declare -i delta=${nextSleep}-${now}-60
    if [[ -z ${delta/0-9//} ]]; then
        # echo "delta     $delta"
        # echo "now       $now"
        # echo "nextSleep $nextSleep"
        date -v+${delta}S
        echo $delta
        if [[ $delta -gt 0 ]]; then
            caffeinate -disu -t $delta
        fi
        # sleep 7200
    fi
    
    sleep 10
done
