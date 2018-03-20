#  alias.sh
#

### Lazy commands
alias rcreload="source ~/.bashrc"               #help= Reload the .bashrc file
alias qbashedit="nano ~/.bashrc"                #help= Open the .bashrc file in nano
alias xcprep="xcode-select --install && sudo xcodebuild -license"  #help= Accept XCode license and get initial command line tools


export ICD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
alias cdi="cd \"$ICD_PATH\""                    #help= CD to the iCloud folder
alias icd="cd \"$ICD_PATH\""                    #help= CD to the iCloud folder

alias cdo="cd $HOME/Documents"                  #help= CD to the Documents folder
alias cde="cd $HOME/Desktop"                    #help= CD to the Desktop folder
alias cdv="cd $HOME/Developer"                  #help= CD to the Developer folder

export PYTHONISTA_PATH="$HOME/Library/Mobile Documents/iCloud~com~omz-software~Pythonista3/Documents"
alias cdpy="cd \"$PYTHONISTA_PATH\""            #help= CD to the Pythonista folder on iCloud

alias cdprofile="cd $PROFILE_DIR && pwd"        #help= CD to the bash_hacks/profile folder
alias cdbh="cd $PROFILE_DIR/.. && pwd"          #help= CD to the bash_hacks folder

alias duh="du -h -d 1"                          #help= Disk Usage, Human readable, depth 1
alias ll="ls -lh"                               #help= List, long view, human readable
alias lsa="ls -lha"                             #help= List, long view, human readable, hidden files too
alias lsaf="clear; lsa; ls -la *"               #help= List, long view and next child folders

alias sourceTreeOpen="open ./ -a /Applications/SourceTree.app"                  #help= Open the current directory in SourceTree
alias ax="chmod a+x"                            #help= /path/to/file => Make a file executable
alias md="open -a /Applications/Marked\ 2.app/ "                                #help= Open a file in the app Marked 2


mkcd(){  #help= Make a directory and cd to it
    mkdir -p $1 && cd $1
}

alias qlynx="cd ${HOME}/Downloads/ && lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies && rm /tmp/lynxcookie"            #help= Start Lynx in the Downloads folder and with accept_all_cookies enabled, and delete the cookie after quit

playground(){ #help= CD to a folder for quick script testing and open that path in Sublime Text
    testDir="${HOME}/priv/test/"
    mkcd $testDir
    subl ${testDir}
}

# Git

alias gdiff="git difftool"                      #help= git difftool
alias gstat="git status"                        #help= git status
alias gadd="git add"                            #help= git add

# Logs

alias glbranch="git log --graph --oneline --all --decorate"                     #help= git log in a pretty format
alias glstat="git log --stat -5"                #help= git log with some stats


# Sublime Text Helpers

alias sbashedit="subl ~/.bashrc --project $PROFILE_DIR/../bash_hacks.sublime-project"                                    #help= open the bash_hacks & profile project in Sublime Text
alias smlcedit="subl ~/.bashrc --project $PROFILE_DIR/../../machete-line-commands/machete-line-commands.sublime-project" #help= open the machete-line-commands project in Sublime Text
alias shost="subl -n /etc/hosts"                #help= open the machine hosts file in Sublime Text


## open files using a filter and a command
#    openFilteredFiles "<filter string>" "<command string>" [../path/]
#  Be sure to quote the filter and command strings
openFilteredFiles(){ #help= "<filter string>" "<command string>" [../path/] => Open files based on a filter. Be sure to quote the filter and command strings.
    filterString="$1" && shift
    commandString="$1" && shift
    myPath="."
    if [[ -n "$1" ]]; then
        myPath="$1" && shift
    fi

    if [[ -z `find "${myPath}" -d 1 -iname $filterString -exec $commandString {} \;` ]]; then
        echo "No files found for filter '$filterString'"
    fi
}

## Open a Sublime Text project file here or at some path
#   subproj [../path/that/contains/a/project/]
alias subproj='openFilteredFiles  "*.sublime-project" "subl --project" '    #help= Open a Sublime Text project file here or at some path

### Date fun
alias dateiso="date \"+%Y%m%d\""                #help= Print the date in ISO 8601 format
alias timeiso="date \"+%Y%m%d-%H%M%S\""         #help= Print the date-time in ISO 8601 format

### Note taking

alias fhist="history > `date '+%Y%m%d_%s'`.hist.$USER.txt"                      #help= Copy the history into a file with the current date

### Useful functions

looping(){
    timeToWait=$1 && shift
    commandToExec=$1 && shift

    while :; do
        $commandToExec
        sleep $timeToWait
    done
}


## Save the results of a command to a variable, and save it so it can be recalled later
tmpCache=""
cacheCommand(){
    inputCommand="$*"
    tmpCache=`$inputCommand`
    echo $tmpCache
}

alias ccmd="cacheCommand"                       #help= .
alias ecmd="echo \$tmpCache"                    #help= .

## Search a file(s)
# searchFile [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"]
searchFile() {
    if [[ $1 == "-d" ]]; then
        shift
        debug=true
    fi
    inputPath=$1 && shift
    grepString=$1 && shift
    additionalString=$1 && shift

    if [[ -n $additionalString ]]; then
        highlightString="(${grepString}|${additionalString})"
    else
        highlightString="(${grepString})"
    fi
    highlightString=`echo ${highlightString} | perl -pe "s/\\//\\\\\\\\\//gi"`
    perlString="s/(`echo ${highlightString}`)/`tput setaf 1`\1`tput sgr0`/gi"

    if [[ $debug ]]; then
        echo "inputPath       = "$inputPath
        echo "grepString      = "$grepString
        echo "perlString      = "$perlString
        echo "highlightString = "$highlightString
        echo "---- ---- ---- ---- ---- ---- ---- ---- "
    fi
    cat $inputPath | grep -E "$grepString" | perl -pe "$perlString"
}


function dockSpacerTile() {
    defaults write \
    com.apple.dock \
    persistent-apps \
    -array-add '{"tile-type"="spacer-tile";}'
    killall Dock
}


function bakThisUp() {   #help= .
    inputFiles=$@
    for thisfile in $inputFiles; do
        cp "$thisfile" "$thisfile.bak-`date "+%Y-%m-%d_%H-%M-%S"`"
    done
}



function cdl(){
    declare target_dir=$1 && shift
    if [[ -e "$target_dir" ]]; then
        clear
        cd $target_dir
        ll -lha
    fi
}

function timeout(){
    my_delay=$1 && shift
    my_command=$*
    ( $my_command ) & sleep $my_delay ; kill $! 
    echo
}








