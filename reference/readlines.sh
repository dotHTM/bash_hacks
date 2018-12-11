#!/usr/bin/env bash



string='1 - hello
2 - there
3 - Mr Potato Head
4 - Wowie Zowie!'

lastChapter=0

while read -r chapterDetails; do
	(( lastChapter += 1 ))
	echo $line
done <<< "$string"
