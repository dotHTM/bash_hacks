#  alias.sh
#

alias bh_update='cd "$BH_PROFILE_DIR/.." && git pull'   #help= cd to the profile directory and update.

### Lazy commands
alias rcreload='source ~/.bashrc'               #help= Reload the .bashrc file
alias qbashedit='nano ~/.bashrc'                #help= Open the .bashrc file in nano
alias vbashedit='vi ~/.bashrc'                #help= Open the .bashrc file in vi

alias cdprofile='cd "$BH_PROFILE_DIR" && pwd'        #help= CD to the bash_hacks/profile folder
alias cdbh='cd "$BH_PROFILE_DIR"/.. && pwd'          #help= CD to the bash_hacks folder

alias duh='du -h -d 1'                          #help= Disk Usage, Human readable, No sub folders
alias ll='ls -lh'                               #help= List, long view, human readable
alias lsa='ls -lha'                             #help= List, long view, human readable, hidden files too
alias lsaf='clear; lsa; ls -la *'               #help= List, long view and next child folders

alias ax='chmod a+x'                            #args= /path/to/file #help= Make a file executable

alias public_key="cat $HOME/.ssh/id_rsa.pub"

mkcd(){  #help= Make a directory and cd to it
    mkdir -p $1 && cd $1
}

alias qlynx="cd ${HOME}/Downloads/ && lynx -cookie_file=/tmp/lynxcookie -accept_all_cookies && rm /tmp/lynxcookie"            #help= Start Lynx in the Downloads folder and with accept_all_cookies enabled, and delete the cookie after quit



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


### Date fun
alias dateiso='date "+%Y%m%d"'                #help= Print the date in ISO 8601 format
alias timeiso='date "+%Y%m%d-%H%M%S"'         #help= Print the date-time in ISO 8601 format

### Note taking

alias fhist='history > `date "+%Y%m%d_%s"`.hist.$USER.txt'                      #help= Copy the history into a file with the current date

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

alias ccmd='cacheCommand'    #args= <command>      #help= shortcut for cacheCommand 
alias ecmd='echo "$tmpCache"'                      #help= get the value of $tmpCache (the last run cacheCommand)

## Search a file(s)
# searchFile [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"]
searchFile() { #args= [-d] "quoted/path/to/*.files" "(search|strings or words)" ["additional pattern to match"] #help= Search a file(s)
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
        echo 'inputPath       = '$inputPath
        echo 'grepString      = '$grepString
        echo 'perlString      = '$perlString
        echo 'highlightString = '$highlightString
        echo '---- ---- ---- ---- ---- ---- ---- ---- '
    fi
    cat $inputPath | grep -E "$grepString" | perl -pe "$perlString"
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








