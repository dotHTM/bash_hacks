#!/usr/bin/env bash

set -e

if [[ -n $(which brew) ]]; then
    echo "==== Homebrew ================================"
    brew update
    brew upgrade
    brew upgrade --cask --greedy
    brew cleanup
    echo
fi