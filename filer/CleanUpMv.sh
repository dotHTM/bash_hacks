#!/usr/bin/env bash

# Cleanup folders by filetype (case sensative)

mkdir -p ./$1

mv ./*.$1 ./$1


