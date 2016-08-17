#!/bin/bash
#
# 

alias dkperl="docker run -it --rm --name my-running-perl-script -v \"$PWD\":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl"
alias dcu="docker-compose up"
alias dcb="docker-compose build; docker-compose up"
alias dcrsubl="docker run -ti --rm testbuild bash"