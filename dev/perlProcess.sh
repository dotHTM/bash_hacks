#!/bin/bash
# perlProcess.sh

someFile=$1 && shift


if [[ -n $someFile ]]; then
    someOutputFilePath=${someFile}_critic.md

    criticSeverity=1
    criticBrevityFormat=' %f at <%l:%c> ::  %m, %e (%s)\\n'
    criticVerboseFormat='## %m <%l:%c> (%s)\\n\\n```perl\\n%r\\n```\\n\\n%d\\n\\n**Policy module:**\\n\\n`%P`\\n\\n> %e\\n\\n'

    perltidy -b $someFile
    perlcritic -$criticSeverity --verbose 4 $someFile
    perlcritic -$criticSeverity --verbose "$criticVerboseFormat" $someFile \
        | perl -pe "s/^(    )//gi" \
        | perl -pe "s/^  (\w.*;)/    \1/gi" \
        | perl -pe "s/\\\`(.*?)(\S)'/\\\`\1\2\\\`/gmi" \
        > $someOutputFilePath



    # subl $someOutputFilePath
    open -a "/Applications/Marked 2.app" $someOutputFilePath

    perl -c $someFile

fi



        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        # | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \