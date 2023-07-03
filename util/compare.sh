#!/usr/bin/env bash
# compare.sh


lhsDir="$1" && shift
rhsDir="$1" && shift

lhsFiles=`find "$lhsDir" -type f`
rhsFiles=`find "$rhsDir" -type f`


uniqL()




for l in $lhsFiles; do
    leftMd5=`md5 "$l"`
    found=0
for r in $rhsFiles; do
    rightMd5=`md5 "$r"`
    
    if [[ $leftMd5 == $rightMd5 ]]; then
        found=1
    fi
done

if [[ -z $found ]]; then
    
fi

done

