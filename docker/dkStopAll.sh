#!/usr/bin/env bash
# dkFullReset.sh

if [[ -n `which docker` ]]; then
    echo "== Containers =="
    for i in $(docker ps --all -q); do
        docker stop $i
    done
else
    echo "Docker not installed"
fi
