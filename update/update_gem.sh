#!/usr/bin/env bash
# update_gem.sh

set -e

if [[ -n $(which gem) ]]; then
    echo "==== Ruby/gem ================================"
    gem update --system
    gem update
    gem cleanup
    echo
fi