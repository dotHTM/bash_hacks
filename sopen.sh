#!/usr/bin/env bash
#

find -E .  -iname "*.sublime-project" ! -iregex ".*/(.*Trash|node_modules)/.*" -exec subl --project {} \;
