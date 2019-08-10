#!/bin/sh

# bash -c "$(curl https://raw.githubusercontent.com/dotHTM/bash_hacks/master/installers/mac_install.sh)"

# Install brew, bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install bash wget

install_parent="$HOME/Developer"

mkdir $install_parent
cd $install_parent
git clone https://github.com/dotHTM/bash_hacks.git

bash $install_parent/bash_hacks/profiles/install.sh

