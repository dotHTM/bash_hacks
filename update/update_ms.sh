#!/usr/bin/env bash
# update_ms.sh

set -e

ms_au_app="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"
if [[ -e "$ms_au_app" ]]; then
    echo "==== MS Office ================================"
    # osascript -e 'tell app "Microsoft Edge" to quit' #edge is not updated via the MS Office AutoUpdate 2 app.
    osascript -e 'tell app "Microsoft Excel" to quit'
    osascript -e 'tell app "Microsoft OneNote" to quit'
    osascript -e 'tell app "Microsoft Outlook" to quit'
    osascript -e 'tell app "Microsoft PowerPoint" to quit'
    osascript -e 'tell app "Microsoft Teams" to quit'
    osascript -e 'tell app "Microsoft Word" to quit'
    open "$ms_au_app"
    echo
fi
