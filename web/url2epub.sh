#!/usr/local/bin/bash
# url2epub.sh
#
#     Usage: url2epub.sh url [title [chapter_level]]
#
##    Takes a URL and makes an Epub from the HTML after cleaning it of divs.
##
##    Optionally takes a title, my_pub_chapter_level values
##
##    Also unzips the resulting epub to verify the contents without having to open
##    in a slow reader app.
##

REQUIRED_BIN='
wget
pandoc
unzip
'

checkRequiredBins(){
    for some_bin in $REQUIRED_BIN; do
        if [[ -n $some_bin && -z `which $some_bin` ]]; then
            bins_lost=$bins_lost"
            - $some_bin"
        fi
    done
    if [[ -n $bins_lost ]]; then
        err_msg="You are missing the following utilities:$bins_lost"
        error "$err_msg"
    fi
}

error(){
    echo "
ERROR: $*
"
    exit
}

main(){
    checkRequiredBins

    my_url=$1 && shift
    my_title=$1 && shift
    my_pub_chapter_level=$1 && shift

    if [[ -z $my_title ]]; then
        my_title=${my_url/*\/}
        my_title=${my_title/\.*}
    fi

    if [[ -z $my_pub_chapter_level ]]; then
        my_pub_chapter_level=2
    fi

    EXEC_DIR=`pwd`
    SOURCE_DIR="$EXEC_DIR/$my_title/source"
    BUILD_DIR="$EXEC_DIR/$my_title/build"
    DEBUG_DIR="$EXEC_DIR/$my_title/debug"


    mkdir -p "$SOURCE_DIR"
    mkdir -p "$BUILD_DIR"
    mkdir -p "$DEBUG_DIR"


    sourceFileName=${my_url/*\/}
    sourceFilePATH="${SOURCE_DIR}/${sourceFileName}"
    buildFilePATH="${BUILD_DIR}/${sourceFileName}-`date "+%s"`.epub"

    cd $SOURCE_DIR && wget -m -k -np -nd $my_url

    perl -pe 's|</?div( .*?)?>||gim' ${sourceFilePATH} > "${sourceFilePATH}.tmp"

    mv "${sourceFilePATH}.tmp" "${sourceFilePATH}"

    cd $SOURCE_DIR && pandoc "${sourceFilePATH}" -o "${buildFilePATH}" --epub-chapter-level=${my_pub_chapter_level}
    cd $DEBUG_DIR && unzip -o "${buildFilePATH}"
}


main $*