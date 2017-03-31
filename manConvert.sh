#!/bin/sh

outputPath="$HOME/Projects/Docs/Man/Sierra/"
mkdir -p $outputPath

commandLookup=$1 && shift
outputFormat=$1 && shift

if [[ -z $commandLookup ]]; then
	echo "No command found"
	exit 1
fi

if [[ -z $outputFormat ]]; then
	outputFormat="html"
fi

commandManPageFile=`man -w $commandLookup`

if [[ -z $commandManPageFile ]]; then
	echo "Man page not found"
	exit 1
fi

mandoc -T $outputFormat `man -w $commandLookup` > ${outputPath}${commandLookup}"."$outputFormat


