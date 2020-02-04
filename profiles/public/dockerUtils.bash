# dockerUtils.sh


if [[ `uname` == 'Darwin' ]]; then
    # Docker Toolbox on Mac
    alias primedocker="/Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh"
fi


if [[ -n `which docker` ]]; then

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

    if [[ -n `which docker-compose` ]]; then
        alias dkc="docker-compose"
        alias dkcu="docker-compose up"
        alias dkcb="docker-compose build"
        alias dkcd="docker-compose down"
        alias dkcr="docker-compose rm -f && `which docker-compose` up"
    fi

fi