# qs_aliaser.bash

if [[ -e "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" ]]; then
    
    make_qs_alias(){
        configURI=$1 && shift
        trailing_handle=$1 && shift
        args_list=$1 && shift
        
        serverShortcutName=`echo $configURI | cut -d "@" -f 2 | tr ":/." "_--"`
        hostNickName=`echo $configURI | perl -pe 's/(?:[^\/:]*@)?(.*):.*/\1/gmi'`
        pathNickName=`echo $configURI | perl -pe 's/\/$//gmi' | perl -pe 's/.*\/.*?/\1/gmi'`

        volPath="$hostNickName-$pathNickName"

        alias 'qs_'${serverShortcutName}'_'${trailing_handle}="quicksshfs.sh -r ${configURI} -v ${volPath} ${args_list}"
    }

    while read someConfigURI; do
        if [[ -n $someConfigURI && -n `echo $someConfigURI | perl -pe 's/^[#;\/].*$//gmi'` ]]; then
            
            make_qs_alias $someConfigURI '' '-sumn'
            make_qs_alias $someConfigURI 'bb' '-bumn'
            
            for some_args in 's' 'f' 'muol' 'nm' 'fm' 'b' ; do
                make_qs_alias $someConfigURI "$some_args" "-$some_args"
            done
        fi
    done < $BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg
fi

