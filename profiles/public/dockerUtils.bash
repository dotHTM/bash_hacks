#!/bin/bash
# dockerUtils.sh

# Docker Toolbox on Mac
alias primedocker="/Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh"

# other functions
alias dkperl="docker run -it --rm --name my-running-perl-script -v \"$PWD\":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl"

alias dkrsubl="docker run -ti --rm testbuild bash"

dke(){
	if [[ -z $@ ]]; then
		command=/bin/bash
	else
		command=$@
	fi
	docker exec -ti `docker ps -l -q` "$command"
}

alias dcompose=`which docker-compose`

alias dcu="docker-compose up"
alias dcb="docker-compose build"
alias dcd="docker-compose down"

alias dcr="docker-compose rm -f && docker-compose up"

