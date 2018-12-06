#!/bin/bash
#
#

BH_PROFILE_DIR=$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )

cd $HOME

bakup_this_rc(){
    somepath=$1 && shift
    if [[ -e "$somepath" ]]; then
        bakup_path="${somepath}.`date '+%F%T'`.bak"
        mv ${somepath} ${bakup_path} && echo "  Backed up file: ${bakup_path}"
    fi
    
}

rc_list='.bashrc
.bash_profile
.profile'

for someRC in $rc_list; do
    bakup_this_rc $someRC
done

touch .bashrc
ln .bashrc .profile
ln .bashrc .bash_profile

echo "####################################
###### Bash hacks profile
export BH_PROFILE_DIR=\"$BH_PROFILE_DIR\"
" >> $HOME/.bashrc

cat "${BH_PROFILE_DIR}/default_rc" >> $HOME/.bashrc

echo "It would be a good idea to look at your .bashrc file and verify it's contents"

ln -s "$HOME/Library/Application Support/Sublime Text 3/Packages/User" "$HOME/.subl_prefs"
