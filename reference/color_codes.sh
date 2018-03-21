#!/usr/local/bin/bash

for color in {0..256} ; do #Colors
    for fgbg in 48 38 ; do #Foreground/Background
		#Display the color
        echo -n $'\e['${fgbg}';5;'${color}'m  '${color}$'\t\e[0m'
    done
    if (( (color <= 15 && (color + 1) % 8 == 0) || (color >= 16 && (color + 3) % 6 == 0) )); then
        echo
    fi 
done

exit 0


