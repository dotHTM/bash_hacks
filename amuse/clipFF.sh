#!/usr/local/bin/bash


inputFile="$1" && shift
outputPath="$1" && shift
timeCode="$1" && shift
length="$1" && shift

fileName=`echo $inputFile  | perl -pe 's^.*/^^gi'`
fileExt=`echo $fileName | perl -pe 's^.*\.^^gi'`

outFileName="${outputPath}/${fileName}_${timeCode/:/.}+${length/:/.}.${fileExt}"

echo outFileName: $outFileName


if [[ -n $inputFile  && -n $outputPath && -n $timeCode && -n $length ]]; then
	ffmpeg -i "$inputFile" \
	-ss "$timeCode" \
	-t "$length" \
	-acodec copy \
	-vcodec copy \
	"$outFileName"
else
	echo "Usage: clipFF.sh <input file> <output directory> <time code> <duration>"
	echo
	echo "   Read \`man ffmpeg-utils\` for valid time code formats"
	echo
fi



