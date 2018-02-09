#!/usr/local/bin/bash

zones='America/Los_Angeles
America/Chicago
America/New_York
UTC
Australia/Sydney
'

format="+  %m/%d - %H:%M %Z"

line="="

for mytz in $zones; do
    echo $mytz
    echo $mytz | perl -pe "s|.|$line|gi" 
    TZ=$mytz date "$format"
    echo
done
