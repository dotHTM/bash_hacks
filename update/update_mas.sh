#!/usr/bin/env bash

set -e

if [[ -n $(which brew) ]]; then
    echo "==== Mac App Store ================================"
    if [[ -n $(which mas) ]]; then
        brew upgrade mas
    else
        brew install mas
    fi
    mas upgrade
    echo
fi
