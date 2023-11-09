#!/usr/bin/env bash
# insomnia.sh


read min sec <<<$(date +'%M %S')
seconds_until_the_next_hour=$(( 3600 - 10#$min*60 - 10#$sec ))
wait_time=$(( $seconds_until_the_next_hour - 10 )) # nudge it a little short.

# echo $seconds_until_the_next_hour
# echo $wait_time

/usr/bin/caffeinate -disu -t $wait_time
