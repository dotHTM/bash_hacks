# qs_aliaser.bash

if [[ -e "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" ]]; then
    
    make_qs_alias(){
        configURI=$1 && shift
        trailing_handle=$1 && shift
        args_list=$1 && shift
        
        echo "##############################################################"
        echo "  configURI        $configURI"
        echo "  trailing_handle  $trailing_handle"
        echo "  args_list        $args_list"
        
        
        serverShortcutName=`echo "$configURI" | cut -d "@" -f 2 | tr " :/." "__--"`
        host=`echo "$configURI" | sed -E 's/([^@]+)@([^:]+):(.*)/\2/'`
        path=`echo "$configURI" | sed -E 's/([^@]+)@([^:]+):(.*)/\3/'` 
        volPath=`echo "$host-$path" | tr ":/." "_--"`
        
        alias 'qs_'${serverShortcutName}'_'${trailing_handle}="quicksshfs.sh -r \"${configURI}\" -v \"${volPath}\" \"${args_list}\""
    }
    
    qs_list=`cat "$BH_PRIVATE_BASHRC_PATH/quicksshfs_alias.cfg" | sed 's/^[#;\/].*$//' | grep -E '\w'`

    while read -r configLine; do
        
        make_qs_alias "$configLine" '' '-sumn'
        make_qs_alias "$configLine" 'bb' '-bumn'
        
        for some_args in 's' 'f' 'fm' 'm' 'b' ; do
            make_qs_alias "$configLine" "$some_args" "-$some_args"
        done
    done <<< "$qs_list"
fi

