#!/bin/ash
# wget -O - https://raw.githubusercontent.com/dotHTM/bash_hacks/master/installers/alpine/alpine.ash | ash
apk update
apk add bash git ncurses
cd && git clone https://github.com/dotHTM/bash_hacks.git
bash $HOME/bash_hacks/profiles/install.sh
patch /etc/passwd -i $HOME/bash_hacks/installers/alpine/etc-passwd.diff
source .bashrc
apk add vim nano
apk add python3 ffmpeg
pip3 install --upgrade pip
clear
bash
