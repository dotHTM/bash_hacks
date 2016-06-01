#!/bin/bash
#
#	Docker Full Reset
# 	Removes all images and processes.

echo "=== Docker Full Reset ==="
echo "-- ps --"
psList=`docker ps --all --format="{{.ID }}" | uniq`
echo "-- removing ps --"
for p in $psList; do
	echo $p
	docker rm -f $p;
done
echo "-- images --" 
imageList=`docker images --format="{{.ID }}" | uniq`
echo "-- removing images --"
for i in $imageList; do
	echo $i
	docker rmi -f $i
done

echo "=== check ==="
docker ps --all
docker images

