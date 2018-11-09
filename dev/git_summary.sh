#!/usr/local/bin/bash
# git_summary.sh
#   Description
#
#   Written by Mike Cramer
#   Started on DATE


parentDirectories=$*
if [[ -z $parentDirectories ]]; then parentDirectories=`pwd`; fi

if [[ -z $TERM ]]; then TERM='dumb'; fi

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

for someParentDir in $parentDirectories; do
    if [[ -e $someParentDir ]]; then
        cd $someParentDir
        back_to_parent=`pwd`
        while read someDir; do
            if [[ -e "$someDir" ]]; then
                while read someGitDir; do
                    cd $back_to_parent
                    if [[ -e "$someGitDir" ]]; then
                        cd "${someGitDir}/.."
                        if [[ -n `git status -s` ]]; then
                            echo "${style_violet}============================================================${style_white}"
                            echo "'${style_yellow}${someGitDir}${style_white}'"
                            echo "${style_cyan}----------------------------------------------------${style_white}"
                            git status -s
                            echo
                        fi
                    fi
                done  <<< `find "$someDir" -name '.git' -d 2`
            fi
        done <<< `find ./ -type d -d 1`
    fi
done
