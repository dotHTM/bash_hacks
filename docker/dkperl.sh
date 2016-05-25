#!/bin/bash
#

docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp perl:5.20 bash