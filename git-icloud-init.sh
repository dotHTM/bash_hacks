#!/bin/bash

projectName=$1

icloudPath="/Users/${USER}/Library/Mobile Documents/com~apple~CloudDocs/"
scmPath="${icloudPath}scm/"
scmType=".git"

echo $projectName

projectPath="/Users/${USER}/Projects/"

echo $projectPath
mkdir -p $projectPath
cd $projectPath
pwd
ls -lha

localRemoteRepo="${scmPath}${projectName}${scmType}"

git init --bare "${localRemoteRepo}"
git clone "${localRemoteRepo}"

cd $projectName

sproj.sh

echo "# $projectName
created by $USER on `date '+%Y-%m-%d'`
" >> README.txt
git add -A

git commit -m "initial commit"
git push

open ./ -a /Applications/SourceTree.app

