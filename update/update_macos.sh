#!/usr/bin/env bash

set -e

if [[ "Darwin" == $(uname) ]]; then
    echo "==== macOS ================================"
    softwareupdate --install --recommended
    echo
fi
