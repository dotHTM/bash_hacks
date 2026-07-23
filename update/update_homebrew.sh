#!/usr/bin/env bash

set -e

if [[ -n $(which brew) ]]; then
    echo "==== Homebrew ================================"
    brew update
    brew upgrade --yes
    brew upgrade --cask --greedy --yes
    brew autoremove
    brew cleanup
    echo
fi