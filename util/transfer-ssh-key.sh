#!/usr/bin/env bash
# transfer-ssh-key.sh


if [[ $BASH_VERSINFO < 4 ]]; then
    echo -n "bash version is \"$BASH_VERSINFO\" and I require at least 4"
    exit
fi

host_list=$@
public_key=`cat $HOME/.ssh/id_rsa.pub`

for host in $host_list; do
    ssh "${host}" -t \
        "
        mkdir -p .ssh/;
        touch .ssh/authorized_keys;
        touch .ssh/authorized_keys2;
        echo '$public_key' >> .ssh/authorized_keys;
        cp .ssh/authorized_keys .ssh/tmp; cat .ssh/tmp | sort | uniq > .ssh/authorized_keys;
        echo '$public_key' >> .ssh/authorized_keys2;
        cp .ssh/authorized_keys2 .ssh/tmp; cat .ssh/tmp | sort | uniq > .ssh/authorized_keys2;
        rm .ssh/tmp;
        "
        
        # vim .ssh/authorized_keys;
        # vim .ssh/authorized_keys2;
    
done




