#!/bin/ash
apk update
apk add bash git ncurses
cd && git clone https://github.com/dotHTM/bash_hacks.git
bash ./bash_hacks/profiles/install.sh
apk add vim nano python3 ffmpeg
pip3 install --upgrade pip
source $HOME/.bashrc