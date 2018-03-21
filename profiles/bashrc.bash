
PROFILE_DIR=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

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

if [[ -n $PROFILE_DIR ]]; then
    for anFile in `find $PROFILE_DIR/public -iname "*.bash"`; do
        source $anFile
    done

    if [[ -n $BH_PRIVATE_BASHRC_PATH ]]; then
        for anFile in `find $BH_PRIVATE_BASHRC_PATH -iname "*.bash"`; do
            source $anFile
        done
    fi
fi

