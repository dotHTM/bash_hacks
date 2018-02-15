#!/usr/local/bin/bash

fileLoc1=$1 && shift
fileLoc2=$1 && shift

alias bf='cat files/snsfw > files/nsfw '
alias cs='cat files/snsfw'
alias ds='cat files/nsfw | sort | uniq > files/snsfw'
alias cl='echo > files/snsfw; echo > files/nsfw'
alias trl='tr " " "\n"'
