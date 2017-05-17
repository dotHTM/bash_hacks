#!/bin/bash
# newGitHubProject.sh
#
#   Written by Mike Cramer
#   Started on 2017-05-17

usage(){
  echo "    Usage: ${0/*\/} <projectName> "
}



inputFileName=$1 && shift

if [[ -n $inputFileName ]]; then
  
  cp -an "${hackParentPath}/dev/template_project" "./"
  mv "template_project" "${inputFileName}"
  cd "./${inputFileName}"
  git init
  git commit --allow-empty -m "empty init"
  
else
  
  usage
  
fi


