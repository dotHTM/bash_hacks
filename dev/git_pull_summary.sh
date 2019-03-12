#!/usr/bin/env bash
# git_pull_summary.sh
#   

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

style_nrml=`tput sgr0`
style_yellow=`tput setaf 3`

for inputDir in $input; do
    cd "$launchDir"
    if [[ -e $inputDir ]]; then
        while read someGitDir; do
            cd "${someGitDir}/.."
            if [[ -z `gitStats` ]]; then
                echo -n $style_yellow
                pwd
                echo -n $style_nrml"    "
                git pull
                echo
            fi
            cd "$launchDir"
        done <<< `find  -L "${inputDir}" -name '.git' -type d`
    fi
done

