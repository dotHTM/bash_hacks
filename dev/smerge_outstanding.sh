#!/usr/bin/env bash
# smerge_outstanding.sh

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
                smerge ./
            fi
            cd "$launchDir"
        done <<< `find -L "${inputDir}" -name '.git'`
    fi
done

