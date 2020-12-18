#!/usr/bin/env bash
# sub-init.sh

name=$1 && shift


if [[ -z $name ]]; then
    echo "Need to specify a project name"
    exit
fi

mkdir -p "./${name}"
cd "./${name}"

git init

touch README.md

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

