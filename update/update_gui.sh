#!/usr/bin/env bash
# updaters that require some sort of gui

set -e

if [[ "Darwin" == $(uname) ]]; then

    echo "==== macOS ================================"
    echo "  -> Opening Software Update"
    open "x-apple.systempreferences:com.apple.preferences.softwareupdate"
    echo

    updater="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"
    if [[ -e "$updater" ]]; then
        echo "==== MS Office ================================"
        # osascript -e 'tell app "Microsoft Edge" to quit' #edge is not updated via the MS Office AutoUpdate 2 app.
        osascript -e 'tell app "Microsoft Excel" to quit'
        osascript -e 'tell app "Microsoft OneNote" to quit'
        osascript -e 'tell app "Microsoft Outlook" to quit'
        osascript -e 'tell app "Microsoft PowerPoint" to quit'
        osascript -e 'tell app "Microsoft Teams" to quit'
        osascript -e 'tell app "Microsoft Word" to quit'
        echo "  -> Opening Microsoft AutoUpdate"
        open "$updater"
        echo
    fi

    updater="/Applications/JetBrains Toolbox.app"
    if [[ -e "$updater" ]]; then
        echo "==== JetBrains ================================"
        echo "  -> Opening JetBrains Toolbox"
        open "$updater"
        echo
    fi

fi
