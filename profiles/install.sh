#!/bin/bash
#
# 

baseDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm ~/.profile
rm ~/.bash_profile

touch ~/.bashrc
ln ~/.bashrc ~/.profile
ln ~/.bashrc ~/.bash_profile


echo "## Bash hacks profile
# source $baseDir/bashrc.sh" >> ~/.bashrc

echo "It would be a good idea to look at your .bashrc file and verify it's contents"