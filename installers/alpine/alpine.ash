#!/bin/ash
# wget -O - https://raw.githubusercontent.com/dotHTM/bash_hacks/master/installers/alpine/alpine.ash | ash
apk update
apk add bash git ncurses
mkdir -p /usr/local/bin/
ln /bin/bash /usr/local/bin/bash
cd && git clone https://github.com/dotHTM/bash_hacks.git
bash $HOME/bash_hacks/profiles/install.sh
apk add vim nano
clear
bash
