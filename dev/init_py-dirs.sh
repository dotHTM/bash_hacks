#!/usr/bin/env bash
# py-init-dirs.sh

targetDir="$1" && shift

if [[ -z $targetDir ]]; then
    echo "Plese specify a directory to insert __init__.py files"
fi

find \
    -E \
    "$targetDir" \
    -type d \
    ! -path "*/.*" \
    ! -path "*/__*" \
    -exec bash -c "touch {}/__init__.py; echo {}/__init__.py"  \;

treeDir=`which tree`

if [[ -n "$treeDir" ]];then 
    echo ""
    tree "$targetDir" --gitignore
fi
