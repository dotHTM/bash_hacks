#!/usr/bin/env bash
# do_updates.sh


set -e 

update_ms.sh

if [[ "Darwin" == $(uname) ]]; then
    echo "==== macOS ================================"
    softwareupdate --install --recommended
    echo
fi

if [[ -n $(which brew) ]]; then
    echo "==== Homebrew ================================"
    brew update
    brew upgrade
    brew upgrade --cask --greedy
    brew cleanup
    echo
fi

update_pip.sh

update_gem.sh
