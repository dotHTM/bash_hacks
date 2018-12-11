#!/usr/bin/env bash
# check_updates.sh

echo "==== Homebrew ================================"
brew outdated -v
echo
echo "==== Python/pip ================================"
pip list -o
echo
echo "==== Ruby/gem ================================"
gem outdated
echo
