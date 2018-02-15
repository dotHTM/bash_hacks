#!/bin/bash
# test_list.sh
#   

t set act dot
t list add space-gov nasa
result=`t list members space-gov | wc -l | perl -pe 's/\s+//gi'`

echo "counted: $result"
if (( $result >= 0 )); then
    echo "Still broken"
else
    echo "looks good"
fi