#!/bin/ash
apk add bash git
cd && git clone https://github.com/dotHTM/bash_hacks.git
cd ./bash_hacks/profiles/ && bash install.sh
apk add vim nano python3 ffmpeg
pip3 install --upgrade pip
usermod -s /usr/bin/bash $USER
source $HOME/.bashrc