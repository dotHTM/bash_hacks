#!/usr/bin/env bash
# tag_file.sh
#   Tag a file
#
#   Written by Mike Cramer
#   Started on Sat Jan 18 14:29:59 2020
##
##  inspired by the research provided by https://brettterpstra.com/2017/08/22/tagging-files-from-the-command-line/

usage() {
  echo "Usage: ${0/*\/} "
  echo "  -h     Print this help"
  echo "  -o     Overwrite Mode "
  echo "  -a     Append Tags Mode "
  echo "  -x     Delete Tags Mode "
  echo "  -r     Read Mode "
  echo "  -i <path>"
  echo "  -f <path>"
  echo "         Input File "
  echo "  -t <tag>"
  echo "         Tag To Be Added"
  
  exit 1
}

set_tags(){
    file_path="$1" && shift
    
    string_list=''

    until [ -z "$1" ]  # Until all parameters used up . . .
    do
        string_list="${string_list}
        <string>$1</string>"
        shift
    done
    
    plist_data="<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
        <plist version=\"1.0\">
            <array>${string_list}
            </array>
        </plist>"

    xattr -w com.apple.metadata:_kMDItemUserTags \
        "${plist_data}" \
        "$file_path"
}

get_tags(){
    file_path="$1" && shift
    mdls -raw -name kMDItemUserTags "$file_path" | perl -pe "s|null||gi; s|[()]||gi; s|^\s+||gi; s|,.*||gi;"
}

doNothing(){
    shift
}



inputTag=''
while getopts "hoaxri:f:t:" inputOptions; do
  case "${inputOptions}" in
    h) usage ;;            ##
    o) overwriteMode=1 ;;  ##
    a) appendTagsMode=1 ;; ##
    x) deleteTagsMode=1 ;; ##
    r) readMode=1 ;; ##

    i) inputFile=${OPTARG} ;; ##
    f) inputFile=${OPTARG} ;; ##

    t) inputTag="${inputTag} ${OPTARG}" ;;   ##

    *) usage ;;            ##
    ##
  esac
done
shift $(( OPTIND - 1 ))

if [[ -z $inputFile ]]; then
    file_path="$1" && shift
else
    file_path="${inputFile}"
fi

if [[ -z $file_path ]]; then
    usage
elif [[ ! -e $file_path ]]; then
    echo "File does not exist"
else
    new_tags="${inputTag} $*"

    if [[ -n $readMode ]]; then
        get_tags $file_path
        exit
    elif [[ -n $appendTagsMode ]]; then
        new_tags="${new_tags} `get_tags $file_path`"
    elif [[ -n $overwriteMode ]]; then
        doNothing ""
    elif [[ -n $deleteTagsMode ]]; then
        new_tags=''
    fi

    set_tags "${file_path}" $new_tags

fi