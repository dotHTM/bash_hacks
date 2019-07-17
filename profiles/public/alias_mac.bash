if [[ `uname` == 'Darwin' ]]; then

    # iCloud
    export BH_ICD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    alias cdi='cd "$BH_ICD_PATH" && pwd'                    #help= CD to the iCloud folder
    alias icd='cd "$BH_ICD_PATH" && pwd'                    #help= CD to the iCloud folder

    alias cde='cd "$HOME/Desktop" && pwd'                    #help= CD to the Desktop folder
    alias cdl='cd "$HOME/Downloads" && pwd'                  #help= CD to the Downloads folder
    alias cdo='cd "$HOME/Documents" && pwd'                  #help= CD to the Documents folder
    alias cdv='cd "$HOME/Developer" && pwd'                  #help= CD to the Developer folder

    alias killTrash="rm -rf ~/.Trash/*" #help= Empty the Trash with `rm`



    # Developer
    export BH_PYTHONISTA_PATH="$HOME/Library/Mobile Documents/iCloud~com~omz-software~Pythonista3/Documents"
    alias cdpy='cd "$BH_PYTHONISTA_PATH" && pwd'            #help= CD to the Pythonista folder on iCloud

    xcprep(){ #help= Accept XCode license and get initial command line tools
        if [[ -e /Applications/Xcode.app ]]; then
            sudo xcode-select -s /Applications/Xcode.app
        else
            xcode-select --install
        fi
        sudo xcodebuild -license
    }

    alias xc-sim-hitman="xcrun simctl erase all"

    alias ops='eval $(op signin)'

fi
