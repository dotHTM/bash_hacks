#!/usr/bin/env bash
# sub-init.sh

name=$1 && shift

if [[ -z $name ]]; then
    myPWD=`pwd`
    name=${myPWD/*\//}
else
    mkdir -p "./${name}"
    cd "./${name}"
fi

now=`date`

if [[ ! -e README.md ]]; then

    echo "## $name

Initialized - $now
"> README.md


fi


projectFile="./${name}.sublime-project"
if [[ ! -e "$projectFile" ]]; then
    echo '{
    "folders":
    [
        {
            "path": "./"
        },
    ],
    "build_systems":[
        {
            "name": "Project Build",
            "cmd": ["env"],
            // "shell_cmd": "env",
        }
    ]
}' > "$projectFile"

fi

if [[ ! -d ./.git ]]; then
    git init
    echo '
    .DS_Store
    *.sublime-workspace
    ' >> "./.gitignore"

    git add *
    git add .*
    git commit -m "init"
fi


subl -p "./${name}.sublime-project"
smerge ./

