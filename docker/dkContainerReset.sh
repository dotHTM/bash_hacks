#!/bin/bash
#
#	Docker Container Reset
# 	Removes all images and processes.

echo "=== Docker Container Reset ==="
echo "-- ps --"
psList=`docker ps --all --format="{{.ID }}" | uniq`
echo "-- removing --"
for p in $psList; do
	echo $p
	docker rm -f $p;
done
echo "=== check ==="
docker ps --all
