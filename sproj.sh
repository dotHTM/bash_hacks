#!/bin/bash
#
# 

sourceFileDir="/Users/${USER}/Projects/scriptUtils_MLC/txt"
sourceFileName="sublime_project.json"
sourceFilePath=${sourceFileDir}/${sourceFileName}

currentDirName=`pwd | perl -pe "s|.*/||gi"`
newFileName="./${currentDirName}.sublime-project"

cp -avn "${sourceFilePath}" "./"
mv "${sourceFileName}" "${newFileName}"

subl --project "${newFileName}" 