#!/usr/bin/env bash
# do_updates.sh

echo "==== Homebrew ================================"
brew update
brew upgrade
brew cleanup
echo
echo "==== Python/pip ================================"
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
echo
echo "==== Ruby/gem ================================"
gem update --system
gem update
gem cleanup
echo
