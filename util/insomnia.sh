#!/usr/bin/env bash
# insomnia.sh



while [[ 1 == 1 ]]; do
    now=`date "+%s"`
    saturday=`date -v6w -v17H -v30M "+%s"`
    declare -i delta=${saturday}-${now} 
    # echo $saturday
    # echo $now
    echo $delta
    if [[ $delta -gt 0 ]]; then
        caffeinate -disu -t $delta
    fi
    sleep 1
done
