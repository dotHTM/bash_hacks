#!/bin/bash
# perlProcess.sh

someFile=$1 && shift


if [[ -n $someFile ]]; then
    someOutputFilePath=${someFile}.md

    criticSeverity=1
    criticBrevityFormat='<<%f>> at <%l:%c> ::  %m, %e (%s)\\n'
    criticVerboseFormat='## <%l:%c> :: %m, %e (%s)\\n\\n```perl\\n%r\\n```\\n\\n%d\\n\\n\\n\\n'

    perltidy -b $someFile
    perlcritic -$criticSeverity --verbose "$criticBrevityFormat" $someFile
    perlcritic -$criticSeverity --verbose "$criticVerboseFormat" $someFile \
        | perl -pe "s/^(    )/>\1/gi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        | perl -pe "s/^> (.*?)\\\`(.*?)'/> \1\\\`(.*?)\\\`/gmi" \
        > $someOutputFilePath

    subl $someOutputFilePath

fi

