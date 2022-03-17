if [[ `uname` == 'Darwin' ]]; then

ssst_iLife(){
    styleKey=$1 && shift
    
    defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName iLifeSlideshows path /System/Library/Frameworks/ScreenSaver.framework/PlugIns/iLifeSlideshows.appex type 0 
    if [[ -n $styleKey ]]; then
        defaults -currentHost write com.apple.screensaver.iLifeSlideshows styleKey $styleKey
        killall cfprefsd
    fi
}

sslist='Floating
Flipup
Reflections
Origami
ShiftingTiles
SlidingPanels
PhotoMobile
HolidayMobile
PhotoWall
VintagePrints
KenBurns
Classic'

for classicSSName in $sslist; do
    alias ssst_${classicSSName}="ssst_iLife $classicSSName"
done


ssreadstate(){
    defaults -currentHost read com.apple.screensaver
    defaults -currentHost read com.apple.screensaver.iLifeSlideshows
}


ssst_Drift(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Drift \
        path "/System/Library/Screen Savers/Drift.saver" \
        type 0 
}


ssst_Monterey(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Monterey \
        path "/System/Library/Screen Savers/Monterey.saver" \
        type 0 
}


ssst_Hello(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Hello \
        path "/System/Library/Screen Savers/Hello.saver" \
        type 0 
}


ssst_Flurry(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Flurry \
        path "/System/Library/Screen Savers/Flurry.saver" \
        type 0 
}


ssst_Arabesque(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Arabesque \
        path "/System/Library/Screen Savers/Arabesque.saver" \
        type 0 
}


ssst_Shell(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName Shell \
        path "/System/Library/Screen Savers/Shell.saver" \
        type 0 
}


ssst_ComputerName(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName "Computer Name" \
        path "/System/Library/Frameworks/ScreenSaver.framework/PlugIns/Computer Name.appex" \
        type 0 
}


ssst_AlbumArtwork(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName "Album Artwork" \
        path "/System/Library/Screen Savers/Album Artwork.saver" \
        type 0 
}


ssst_Word(){
    defaults -currentHost write com.apple.screensaver moduleDict -dict \
        moduleName "Word of the Day" \
        path "/System/Library/Screen Savers/Word of the Day.saver" \
        type 0 
}


fi