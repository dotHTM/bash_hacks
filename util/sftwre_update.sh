#!/bin/bash
# sftwre_update.sh

for (( i = 0; i < 100; i++ )); do
    echo
done

nowDate=`date "+%s"`
softwareupdate -l 2> /tmp/softwareupdateERR.${nowDate} 
cat /tmp/softwareupdateERR.${nowDate}
echo "----"
date