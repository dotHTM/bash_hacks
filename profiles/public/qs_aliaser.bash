# qs_aliaser.bash

if [[ -e "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" ]]; then
    
    make_qs_alias(){
        configURI=$1 && shift
        trailing_handle=$1 && shift
        args_list=$1 && shift
        
        serverShortcutName=`echo $configURI | cut -d "@" -f 2 | tr ":/." "_--"`
        host=`echo $configURI | sed -E 's/([^@]+)@([^:]+):(.*)/\2/'`
        path=`echo $configURI | sed -E 's/([^@]+)@([^:]+):(.*)/\3/'` 
        volPath=`echo "$host-$path" | tr ":/." "_--"`
        
        

        alias 'qs_'${serverShortcutName}'_'${trailing_handle}="quicksshfs.sh -r ${configURI} -v ${volPath} ${args_list}"
    }
    
    qs_list=`cat "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" | sed 's/^[#;\/].*$//' | grep -E '\w'`

    while read someConfigURI; do
            # echo " - $someConfigURI"
            make_qs_alias $someConfigURI '' '-sumn'
            make_qs_alias $someConfigURI 'bb' '-bumn'
            
            for some_args in 's' 'f' 'fm' 'm' 'b' ; do
                make_qs_alias $someConfigURI "$some_args" "-$some_args"
            done
    done <<< "$qs_list"
fi

