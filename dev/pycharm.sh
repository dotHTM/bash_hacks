#!/usr/bin/env bash
# pycharm.sh

# from https://www.jetbrains.com/help/pycharm/opening-files-from-command-line.html#macos
# and https://www.jetbrains.com/help/pycharm/working-with-the-ide-features-from-command-line.html



arguments="$@"

open -na "PyCharm.app" --args "${arguments}"
