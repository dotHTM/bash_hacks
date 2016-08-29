#!/bin/bash
#
# 

alias dkperl="docker run -it --rm --name my-running-perl-script -v \"$PWD\":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl"

dke(){
	docker exec -ti `docker ps -l -q` bash
}

alias dcu="docker-compose up"
alias dcb="docker-compose build"
alias dcd="docker-compose down"


alias dcrsubl="docker run -ti --rm testbuild bash"

