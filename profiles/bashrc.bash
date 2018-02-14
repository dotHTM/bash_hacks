
profileDir=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

path_add_element(){
    until [ -z "$1" ]; do
        x=$1 && shift
        case ":$PATH:" in
            *":$x:"*) :;;        # already there
            *) PATH="$x:$PATH";; # add the path
            #
        esac
    done
}

if [[ -n $profileDir ]]; then
    for anFile in `find $profileDir/public -iname "*.bash"`; do
    # echo $anFile
    source $anFile
done

if [[ -n $BH_PRIVATE_BASHRC_PATH ]]; then
    for anFile in `find $BH_PRIVATE_BASHRC_PATH -iname "*.bash"`; do
    # echo $anFile
    source $anFile
done
fi

dedupe_paths(){
    ## Dedupe paths taken from https://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
    if [ -n "$PATH" ]; then
        old_PATH=$PATH:; PATH=
        while [ -n "$old_PATH" ]; do
            x=${old_PATH%%:*}       # the first remaining entry
            case $PATH: in
                *:"$x":*) ;;          # already there
                *) PATH=$PATH:$x;;    # not there yet
                #
            esac
            old_PATH=${old_PATH#*:}
        done
        PATH=${PATH#:}
        unset old_PATH x
    fi
}

fi

