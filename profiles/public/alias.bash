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

alias duh="du -h -d 1"                          #help= Disk Usage, Human readable, No sub folders
alias ll="ls -lh"                               #help= List, long view, human readable
alias lsa="ls -lha"                             #help= List, long view, human readable, hidden files too
alias lsaf="clear; lsa; ls -la *"               #help= List, long view and next child folders

alias sourceTreeOpen="open ./ -a /Applications/SourceTree.app"                  #help= Open the current directory in SourceTree
alias ax="chmod a+x"                            #args= /path/to/file #help= Make a file executable
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
openFilteredFiles(){ #args= "<filter string>" "<command string>" [../path/] #help= Open files based on a filter. Be sure to quote the filter and command strings.
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

looping(){ #args= <time to wait in seconds> <command> #help= Repeat a command waiting some seconds between
    timeToWait=$1 && shift
    commandToExec=$1 && shift

    while :; do
        $commandToExec
        sleep $timeToWait
    done
}


## Save the results of a command to a variable, and save it so it can be recalled later
tmpCache=""
cacheCommand(){ #args= <command> #help= Run a command and save it into a variable $tmpCache
    inputCommand="$*"
    tmpCache=$($inputCommand)
    echo $tmpCache
}

alias ccmd="cacheCommand"    #args= <command>      #help= shortcut for cacheCommand 
alias ecmd='echo "$tmpCache"'                      #help= get the value of $tmpCache (the last run cacheCommand)

## Search a file(s)
# searchFile [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"]
searchFile() { #args= searchFile [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"] #help= Search a file(s)
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


function dockSpacerTile() { #args= [apps|docs [small]] #help= Create a blank Dock item on the Apps side
    my_side=$1 && shift
    my_small=$1 && shift
    
    if [[ "${my_side}" =~ "docs" || "docs" =~ "${my_side}" ]]; then
        echo "docs"
        tile_side="persistent-others"
    else
        echo "apps"
        tile_side="persistent-apps"
    fi

    if [[ "${my_small}" =~ "small" || "small" =~ "${my_small}" ]]; then
        echo "small"
        tile_size='{"tile-type"="small-spacer-tile";}' 
    else
        echo "large"
        tile_size='{"tile-type"="spacer-tile";}'
    fi
    defaults \
        write com.apple.dock "${tile_side}" \
        -array-add "$tile_size" \
        && killall Dock
}

function bakThisUp() {  #args= /path/to/file #help= backup a file using iso datetime
    inputFiles=$@
    for thisfile in $inputFiles; do
        cp "$thisfile" "$thisfile.bak-`date "+%Y-%m-%d_%H-%M-%S"`"
    done
}

function cdl(){ #args= /some/path/ #help= clear screen and list all files of path
    declare target_dir=$1 && shift
    if [[ -e "$target_dir" ]]; then
        clear
        cd $target_dir
        ll -lha
    fi
}

function timeout(){ #args= <number of seconds> <command> #help= run a command and kill it if it takes more than the timeout
    my_delay=$1 && shift
    my_command=$*
    ( $my_command ) & sleep $my_delay ; kill $! 
    echo
}








