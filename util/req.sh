#!/bin/bash

### This is a terrible hack and is diffiult to use, I hate bash...

REQUEST_HISTORY="$HOME/.req-packages.bash"
touch "$REQUEST_HISTORY"

while getopts "s" intputOptions; do
  case "${intputOptions}" in
    s) use_sudo=1 ;;
    *) ;;
  esac
done
shift $((OPTIND-1))

manager_bin=$1 && shift

case $manager_bin in
    cpan* | other_bin_here )
        action_verb=""
        ;;
    * ) # Default case
        action_verb=$1 && shift
        ;;
esac


packages_list=$@
date_now=`date "+%F_%T"`

my_hostname=`hostname`
if [[ -n $BH_VANITY_HOSTNAME ]]; then
    my_hostname=$BH_VANITY_HOSTNAME
fi

for some_package in $packages_list; do
    command_handoff="${manager_bin} ${action_verb} ${some_package}"
    comment_remart="    ## ${date_now} - ${my_hostname} "
    if [[ -n $use_sudo ]]; then
        command_handoff="sudo ${command_handoff}"
    fi
    $command_handoff 
    echo "${command_handoff} ${comment_remart}" >> "$REQUEST_HISTORY"
    # if [[ -n $use_sudo ]]; then sudo -k; fi
done



