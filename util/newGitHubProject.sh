#!/usr/bin/env bash
# newGitHubProject.sh
#
#   Written by Mike Cramer
#   Started on 2017-05-17

usage(){
  echo "    Usage: ${0/*\/} <projectName> "
}



inputFileName=$1 && shift

if [[ -n $inputFileName ]]; then
  
  cp -an "${HACK_PARENT_PATH}/dev/template_project" "./"
  mv "template_project" "${inputFileName}"
  cd "./${inputFileName}"
  mv "template_project.sublime-project" "${inputFileName}.sublime-project"
  git init
  mv ./config ./.git/config
  git commit --allow-empty -m "empty init"
  
else
  
  usage
  
fi


