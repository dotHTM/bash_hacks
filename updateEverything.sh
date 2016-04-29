#!/bin/bash
#
# 

echo
echo "==== ports ===="
sudo /opt/local/bin/port selfupdate
sudo /opt/local/bin/port upgrade outdated

echo
echo "==== brew ===="
/usr/local/bin/brew update
/usr/local/bin/brew upgrade

echo
echo "==== gem ===="
/usr/local/bin/gem update --system
/usr/local/bin/gem update

echo
echo "==== npm ===="
/usr/local/bin/npm update -g

echo
echo "==== apple ===="
/usr/sbin/softwareupdate -i -a


echo

