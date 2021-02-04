#!/usr/bin/env bash
# print-hello-world.sh

inputString=$1 && shift
sleepTime=$1 && shift
lolcatFlag=$1 && shift
characterMode=$1 && shift

inputString=`echo "$inputString" | sed -e 's/\(.\)/\1 /g'`

main (){
    while [[ -n 1 ]]; do
        if [[ -n $characterMode ]]; then
            for char in $inputString; do
                echo -ne "$char"
                sleep $sleepTime
            done
            echo -ne " "
            sleep $sleepTime
        else
            echo -ne "$inputString"
            echo -ne " "
            sleep $sleepTime
        fi
    done
}

if [[ -n $lolcatFlag ]]; then
    lolcatBin=`which lolcat`
    if [[ -z $lolcatBin ]]; then
        echo "Can't Find lolcat, exiting"
        exit
    fi
    main | $lolcatBin
else
    main
fi


