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

git init

now=`date`

echo "## $name

Initialized - $now
"> README.md

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
}' > "./${name}.sublime-project"

echo '
.DS_Store
*.sublime-workspace
' > "./.gitignore"


git add *
git add .*
git commit -m "init"



subl -p "./${name}.sublime-project"
smerge ./

