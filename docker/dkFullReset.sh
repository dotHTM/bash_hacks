#!/usr/bin/env bash
# dkFullReset.sh

if [[ -n `which docker` ]]; then
    echo "== Containers =="
    for i in $(docker ps --all -q); do
        docker rm --force $i
    done
    echo "== Images =="
    for i in $(docker images --all -q); do
        docker rmi --force $i
    done
    echo "== Volumes =="
    for i in $(docker volume ls -q); do
        docker volume rm $i
    done
    echo "== Builder =="
    docker builder prune --all --force

else
    echo "Docker not installed"
fi
