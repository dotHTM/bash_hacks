#!/usr/bin/env bash
# dkJanitor.sh

if [[ -n `which docker` ]]; then
    echo "== Containers =="
    for i in $(docker ps -q -f 'status=exited'); do
        docker rm $i
    done

    echo "== Images =="
    for i in $(docker images -q -f "dangling=true"); do
        docker rmi $i
    done

    echo "== Volumes =="
    for i in $(docker volume ls -q -f 'dangling=true'); do
        docker volume rm $i
    done
else
    echo "Docker not installed"
fi
