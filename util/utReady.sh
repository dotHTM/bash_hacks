#!/usr/bin/env bash

readyDir="${HOME}/Desktop/UTReady/"

decompressedDir="${readyDir}/decompressed/"
umodDir="${readyDir}/umods/"

mkdir -p "$readyDir"
mkdir -p "$decompressedDir"
mkdir -p "$umodDir"

cd $readyDir

decompress(){
    archiveFile=$1 && shift
    echo "$archiveFile"
    if [[ -f $archiveFile ]]; then
        filename="${archiveFile/*\/}"
        fn="${filename/.*}"
        contents="${decompressedDir}/${fn}"
        echo "$contents"
        mkdir -p "$contents"
        unar -s \
            -o $contents \
            $archiveFile
    fi
}

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in `find "$readyDir" -iname "*.zip"`; do
    decompress "$f"
done
IFS=$SAVEIFS

find "$readyDir" -iname "*.umod" -exec mv {} "$umodDir" \;

find "$readyDir" -type d -exec utmod.sh {} \;
utmod.sh "$readyDir"

