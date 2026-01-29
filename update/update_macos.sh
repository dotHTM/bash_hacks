#!/usr/bin/env bash

set -e

if [[ "Darwin" == $(uname) ]]; then
    echo "==== macOS ================================"
    open "x-apple.systempreferences:com.apple.preferences.softwareupdate"
    echo
fi
