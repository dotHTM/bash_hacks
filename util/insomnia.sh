#!/usr/bin/env bash
# insomnia.sh


echo "################################"
date
echo "----------------------------"


while [[ 1 == 1 ]]; do


    now=`date "+%s"`
    nextSleep=`date -v11H -v30M "+%s"`
    declare -i delta=${nextSleep}-${now}-60
    if [[ "$delta"  =~ ^[0-9]+$ ]]; then
        echo  "waiting for lunch time"
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
    
    
    now=`date "+%s"`\
    nextSleep=`date -v16H -v30M "+%s"`
    declare -i delta=${nextSleep}-${now}-60
    if [[ "$delta"  =~ ^[0-9]+$ ]]; then
        echo  "waiting for the end of the work day"
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
    
    sleep 60
done
