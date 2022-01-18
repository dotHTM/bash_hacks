#!/usr/bin/env bash
# utmod.sh


for var in "$@"; do
    if [[ $var == "-h" || $var == "--help" ]]; then
        echo "usage: $0 <list of folder paths with UT assets> ..."
    fi
done


extFolderList='
utx Textures
unr Maps
uax Sounds
umx Music
u System
ini System
int System
'

macUTFolder="${HOME}/Library/Application Support/Unreal Tournament/"

if [[ -d "$UT_FOLDER" ]]; then
    UTFolder="$UT_FOLDER"
elif [[ -d "$macUTFolder" ]]; then
    UTFolder="$macUTFolder"
else
    echo "Couldn't resolve UT Folder path. Please specify in the env as 'UT_FOLDER'"
    if [[ -n "$UT_FOLDER" ]]; then
        echo "current \$UT_FOLDER: '$UT_FOLDER'"
    fi
    exit
fi

organizeFolder(){
    ext=$1
    dir=$2
    
    if [[ `find ./ -iname "*.$ext" -d 1 | wc -l` -gt 0 ]]; then
        echo  "## '$dir'    '$ext'"
        find ./ -iname "*.$ext" -exec cp -van {} "$UTFolder/$dir/" \;
    fi
}

organizeFile(){
    file=$1
    
    fileExt=${file/*./}
    while read line; do
        testExt=${line/ */}
        dir=${line/* /}
        if [[ -n $line ]]; then
            if [[ "$fileExt" == "$testExt" ]]; then
                cp -van $file "$UTFolder/$dir/"
            fi
        fi
    done <<< $extFolderList
}


organizeAllIn(){
    cd "$var"
    while read line; do
        if [[ -n $line ]]; then
            organizeFolder $line
        fi
    done <<< $extFolderList
}

here=`pwd`
for var in "$@"
do
    cd "$here"  
    if [[ -d "$var" ]]; then
        organizeAllIn "$var"
    elif [[ -e "$var" ]]; then
        organizeFile "$var"
    fi
done
