#!/usr/bin/env bash
# dkFullReset.sh

if [[ -n `which docker` ]]; then
    echo "== Volumes =="
    for i in $(docker volume ls -q); do
        docker volume rm $i
    done
else
    echo "Docker not installed"
fi
