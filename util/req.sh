#!/bin/bash

bin_path=$1 && shift
request=$1 && shift

date_now=`date "+%F_%T"`

echo "${date_now} || ${bin_path} ${request}" >> ~/.${bin_path}-req-packages.txt
${bin_path} ${request}