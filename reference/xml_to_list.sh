#!/bin/bash
# Convert an XML Key-Value pair to a text file

echo > ~/Desktop/OutputASlist.txt

lineMode="key"

while read line
do

	case "$lineMode" in
		"key"			)	newPropertyKey=`echo $line | perl -pe 's|.*?<key>(.*?)</.*|$1|'`
								if [ "$newPropertyKey" != "$line" ]
								then
									propertyKey=$newPropertyKey
									lineMode="value"
								fi;;

		"value"		)	propertyValue=`echo $line | perl -pe 's|.*?<.*?>(.*?)</.*|"$1"|'`
								lineMode="key"
								case "$propertyKey" in 
									"abbreviation"	) echo $propertyKey:: $propertyValue;;
									"plainText"			) echo $propertyKey:: $propertyValue;;
									*								) ;;
								esac;;
		*				)	;;
	esac

done < /Users/$USER/Desktop/Settings.textexpander

figlet "I'm done!!!"
