#!/usr/local/bin/bash
# git_summary.sh
#   Description
#
#   Written by Mike Cramer
#   Started on DATE

style_bold=`tput bold`
style_undl=`tput smul`
style_revE=`tput rev`
style_blnk=`tput blink`
style_nrml=`tput sgr0`

style_black=`tput setaf 0`
style_red=`tput setaf 1`
style_green=`tput setaf 2`
style_yellow=`tput setaf 3`
style_blue=`tput setaf 4`
style_violet=`tput setaf 5`
style_cyan=`tput setaf 6`
style_white=`tput setaf 7`

style_black_bright=`tput setaf 8`
style_red_bright=`tput setaf 9`
style_green_bright=`tput setaf 10`
style_yellow_bright=`tput setaf 11`
style_blue_bright=`tput setaf 12`
style_violet_bright=`tput setaf 13`
style_cyan_bright=`tput setaf 14`
style_white_bright=`tput setaf 15`

gitStats(){
    status=`git status -s`
    if [[ -n `git remote` ]]; then
        branchStatus=`git status -s -b`
        branchStatus=${branchStatus/"$status"/}
        remoteBranchStatus=${branchStatus/*\[/}
        if [[ $remoteBranchStatus != $branchStatus ]]; then
            git status -s -b
        elif [[ -n $status ]]; then
            git status -s
        fi
    else
        if [[ -n $status ]]; then
            git status -s
        fi
    fi
}

launchDir="`pwd`"

input=$*
if [[ $input == '' ]]; then
    input="./"
fi

for inputDir in $input; do
    cd "$launchDir"
    if [[ -e $inputDir ]]; then
        while read someGitDir; do
            cd "${someGitDir}/.."
            if [[ -n `gitStats` ]]; then
                echo "${style_violet}================================================================${style_white}"
                echo "'${style_yellow}`pwd`${style_white}'"
                echo "${style_cyan}-------------------------------------------------------${style_white}"
                gitStats
                echo
            fi
            cd "$launchDir"
        done <<< `find "${inputDir}" -name '.git' -type d`
    fi
done

