#  alias.sh
#

### Lazy commands
alias rcreload="source ~/.bashrc"
alias qbashedit="nano ~/.bashrc"
alias xcprep="xcode-select --install && sudo xcodebuild -license"

export ICD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
alias cdi="cd \"$ICD_PATH\""
alias icd="cd \"$ICD_PATH\""

alias cdo="cd $HOME/Documents"
alias cde="cd $HOME/Desktop"
alias cdv="cd $HOME/Developer"

export PYTHONISTA_PATH="$HOME/Library/Mobile Documents/iCloud~com~omz-software~Pythonista3/Documents"
alias cdpy="cd \"$PYTHONISTA_PATH\""

alias cdprofile="cd $profileDir && pwd"
alias cdbh="cd $profileDir/.. && pwd"

alias duh="du -h -d 1"
alias ll="ls -lh"
alias lsa="ls -lha"
alias lsaf="clear; lsa; ls -la *"

alias sourceTreeOpen="open ./ -a /Applications/SourceTree.app"
alias ax="chmod a+x"
alias md="open -a /Applications/Marked\ 2.app/ "


mkcd(){
    mkdir -p $1 && cd $1
}

alias qlynx="cd ~/Downloads/ && lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies && rm /tmp/lynxcookie"

playground(){
    testDir="${HOME}/priv/test/"
    mkcd $testDir
    subl ${testDir}
}

# Git

alias gdiff="git difftool"
alias gstat="git status"
alias gadd="git add"

# Logs

alias glbranch="git log --graph --oneline --all --decorate"
alias glstat="git log --stat -5"


# Sublime Text Helpers

alias sbashedit="subl ~/.bashrc --project $profileDir/../bash_hacks.sublime-project"
alias smlcedit="subl ~/.bashrc --project $profileDir/../../machete-line-commands/machete-line-commands.sublime-project"
alias shost="subl -n /etc/hosts"


## open files using a filter and a command
#    openFilteredFiles "<filter string>" "<command string>" [../path/]
#  Be sure to quote the filter and command strings
openFilteredFiles(){
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
alias subproj='openFilteredFiles  "*.sublime-project" "subl --project" '

### Date fun
alias dateiso="date \"+%Y%m%d\""
alias timeiso="date \"+%Y%m%d-%H%M%S\""

### Note taking

alias fhist="history > `date '+%Y%m%d_%s'`.hist.$USER.txt"

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

alias ccmd="cacheCommand"
alias ecmd="echo \$tmpCache"

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


function bakThisUp() {
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








