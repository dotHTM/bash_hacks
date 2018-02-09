#!/usr/local/bin/bash


cd ~/Desktop
mkdir -p unicodeHTML
cd unicodeHTML
rm ./*

for integerY in `seq -w 0 999`; do

	thisFileName="output$integerY.md"

	for runOnce in '1'; 	do
		echo '# Unicode page '$integerY
		echo
		echo '| Number | Unicode | | Number | Unicode | | Number | Unicode | | Number | Unicode | | Number | Unicode | '
		echo '|---|'
	done > $thisFileName

	for integerX in `seq -w 0 99`; do
		for integerZ in `seq -w 0 4`; do
			echo -n '| '$integerY$integerZ$integerX' | &#'$integerY$integerZ$integerX'; | '
		done
		echo
		
		for integerZ in `seq -w 5 9`; do
			echo -n '| '$integerY$integerZ$integerX' | &#'$integerY$integerZ$integerX'; | '
		done
		echo
				
	done >> $thisFileName

done