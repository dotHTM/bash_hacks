#!/usr/bin/env bash
# setssaver.sh

# Details learned from https://discussions.apple.com/thread/7041066

STYLEKEY=$1 && shift
IMAGEFOLDERPATH=$1 && shift

usage(){
    echo "setssaver.sh <styleKey> [<image folder path>]"
    echo
    echo "Valid STYLEKEYs:"
    echo ""
    echo "    Floating"
    echo "    Flipup"
    echo "    Reflections"
    echo "    Origami"
    echo "    ShiftingTiles"
    echo "    SlidingPanels"
    echo "    PhotoMobile"
    echo "    HolidayMobile"
    echo "    PhotoWall"
    echo "    VintagePrints"
    echo "    KenBurns"
    echo "    Classic"
    
}

if [[ -n $STYLEKEY ]]; then
    /usr/bin/defaults \
        -currentHost \
        write \
        com.apple.ScreenSaver.iLifeSlideshows 'styleKey' \
        -string ${STYLEKEY}

    if [[ -n $IMAGEFOLDERPATH ]]; then
        if [[ -d "$IMAGEFOLDERPATH" ]]; then
            /usr/bin/defaults -currentHost write com.apple.ScreenSaverPhotoChooser 'SelectedFolderPath' "${IMAGEFOLDERPATH}"
            /usr/bin/defaults -currentHost write com.apple.ScreenSaverPhotoChooser 'ShufflesPhotos' -bool "true"
        else
            echo "Could not find folder '$IMAGEFOLDERPATH'."
        fi
    fi

    killall cfprefsd
    
else
    usage
fi 
