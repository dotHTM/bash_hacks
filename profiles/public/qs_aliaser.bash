# qs_aliaser.bash

if [[ -e "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" ]]; then
    make_qs_alias(){
        someServer=$1 && shift
        trailing_handle=$1 && shift
        args_list=$1 && shift
        
        serverShortcutName=`echo $someServer | cut -d "@" -f 2 | tr ":/." "_--"`
        hostNickName=`echo $someServer | perl -pe 's/(?:.*@)?(.*):.*/\1/gmi'`
        pathNickName=`echo $someServer | perl -pe 's/\/$//gmi' | perl -pe 's/.*\/.*?/\1/gmi'`

        volPath="$hostNickName-$pathNickName"

        alias 'qs_'${serverShortcutName}'_'${trailing_handle}="quicksshfs.sh -r ${someServer} -v ${volPath} ${args_list}"
    }

    while read someServer; do
        if [[ -n $someServer && -n `echo $someServer | perl -pe 's/^[#;\/].*$//gmi'` ]]; then
            
            make_qs_alias $someServer '' '-sumn'
            
            for some_args in 's' 'f' 'muol' 'nm' ; do
                make_qs_alias $someServer "$some_args" "-$some_args"
            done
        fi
    done < $BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg
fi
