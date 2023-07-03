#!/usr/bin/env bash
# scaleAt.sh


scaleFactor="$1" && shift
parentDirPath="$1" && shift

scalePercent="${scaleFactor}00%"
newParentFolder="${parentDirPath}@${scaleFactor}"

cp -van "$parentDirPath" "$newParentFolder"; mogrify -scale "$scalePercent" "$newParentFolder"/*
