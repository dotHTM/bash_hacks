#!/usr/bin/env bash
# bh_update.sh

style_nrml=`tput sgr0`
style_red=`tput setaf 1`
style_yellow=`tput setaf 3`

stashPull(){
    workingDir="$1" && shift

    if [[ ! -d $someDir ]]; then return 0; fi
    
    echo ${style_yellow}"## Updating: "${style_red}${workingDir}${style_nrml}
    pushd "$workingDir"
    git stash save
    git pull
    echo ${style_yellow}"### Done!: "${style_red}${workingDir}${style_nrml}
    popd
    echo ""
    echo ""
    
    return 1
}

repoDirs="
$BASH_HACK_PARENT_PATH
$HOME/.config/fish
"

while read someDir; do
    stashPull "${someDir}"
done <<< ${repoDirs}