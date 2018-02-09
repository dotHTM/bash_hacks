#!/usr/local/bin/bash
# colortable.sh
#   

if [[ -z "$TERM" ]]; then
	export TERM="dumb"
fi

tput init

for i in `seq -w 0 255`; do

	j=`echo $i | perl -pe 's/^0+//'`
	k=`echo $i | perl -pe 's/^0/ /'`
	
	if [[ -z $j ]]; then
		j=0
		k="  0"
	fi
	echo -n "`tput setab $j` $k `tput sgr0`"
	echo -n "`tput setaf $j` $k `tput sgr0`"

	if (( (j <= 15 && (j + 1) % 8 == 0) || (j >= 16 && (j + 3) % 6 == 0) )); then
		tput sgr0
		echo
	fi 
done
echo



