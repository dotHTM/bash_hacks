#!/usr/bin/env bash
# epochdate.sh
#   Description
#
#   Written by Mike Cramer
#   Started on DATE


i="0000000001"
c=0
thruDate=""

echo 'count,seconds,nextSeconds,year,month,day,hour,minute,second,nextYear,nextMonth,nextDay,nextHour,nextMinute,nextSecond' > epochLoop.csv



uniqueList=""
cycleContinue=true
while [[ $cycleContinue ]]; do
	let c++
	
	tmp=`date -u -j -f "%s" "$i" "+%m%d%H%M%S"`
	
	mapDate=`date -u -j -f "%s" "$i" "+%Y,%m,%d,%H,%M,%S"`
	tmpmapDate=`date -u -j -f "%s" "$tmp" "+%Y,%m,%d,%H,%M,%S"`	
	
	echo "$c $i => $mapDate"
	echo $c,$i,$tmp,$mapDate,$tmpmapDate >> epochLoop.csv
	
	for point in uniqueList; do
		if [[ $cycleContinue ]]; then
			if [[ $point == $tmp ]]; then
				cycleContinue=false
			fi
		fi
	done
	
	if [[ $cycleContinue ]]; then
		i=$tmp
		if (( $c <= 2 )); then
			uniqueList="$uniqueList $i"
		fi
		# echo $uniqueList
	else
		echo "Found loop"
	fi
	
done

