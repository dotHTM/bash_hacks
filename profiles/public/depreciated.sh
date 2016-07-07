#!/bin/bash
# depreciated.sh

# These aliases have been depreciated, they will produce an error message and exit.

depreciatedError(){
	echo
	echo "This alias will be depreciated soon. - " $1
	echo
	echo "If you'd really like to still use this, prefix the command with \"DEP\""
	echo
}

# fixopenwith

fixopenwith(){
	depreciatedError "Recent macOS appears to not suffer this problem as often."
}
alias DEPfixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
