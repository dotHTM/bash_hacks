#!/bin/bash
# perlProcess.sh

criticSeverity=$1 && shift
criticKISFormat='(%s)<%l:%c> '
criticBrevityFormat='f:%f l:%l c:%c m:(%s) %m\r'
criticVerboseFormat='## %m <%l:%c> (%s)\\n\\n```perl\\n%r\\n```\\n\\n%d\\n\\n**Policy module:**\\n\\n`%P`\\n\\n> %e\\n\\n'

main(){
    someFile=$1 && shift
    someOutputFilePath=${someFile}_critic.md


    if [[ -n $someFile ]]; then
        check_syntax_formatted \
        && do_tidy && critic_returnValue=`critic_step` 
        echo "$critic_returnValue"
        
        if [[  "$critic_returnValue" == *"source OK"* ]]  ; then 
            underlined_echo "> Running script - $someFile" '-'
            perl $someFile
        fi
    fi
}

underlined_echo(){
    message=$1 && shift
    character=$1 && shift
    echo $message
    echo $message | perl -pe "s/./$character/gi"
}

check_syntax(){
    perl -c $someFile
}

check_syntax_formatted(){
    perl -c $someFile 2>&1 \
    | perl -pe 's|\n|xxxLINExxx|' | perl -pe 's|xxxLINExxx\s+|, |' | perl -pe 's|xxxLINExxx|\n|g' \
    | perl -pe 's|^(.*) at (.*) line (\d+)(,.*)(?:(?:\n    )(.*))?|f:\2 l:\3 c:1 m:\1\4 \5|gmi'
}

do_tidy(){
    perltidy -b $someFile
}

critic_step(){
    # critic_KIS
    brief=`critic_brief`
    echo $brief
    
    if [[ $brief == *" source OK"* ]]; then
        echo
    else
        critic_markdown
    fi
}

critic_KIS(){
    echo `perlcritic -$criticSeverity --verbose "$criticKISFormat" $someFile`
}

critic_brief(){
    echo `perlcritic -$criticSeverity --verbose "$criticBrevityFormat" $someFile`
}

critic_markdown(){
    
    perlcritic -$criticSeverity --verbose "$criticVerboseFormat" $someFile \
    | perl -pe "s/^(    )//gi" \
    | perl -pe "s/^  (\w.*;)/    \1/gi" \
    | perl -pe "s/\\\`(.*?)(\S)'/\\\`\1\2\\\`/gmi" \
    > $someOutputFilePath
    
    open -g -a "/Applications/Marked 2.app" $someOutputFilePath
    
}


main $*

