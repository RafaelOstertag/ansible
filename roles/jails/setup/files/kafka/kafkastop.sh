#!/bin/sh

pkill java
i=0
while pgrep java > /dev/null
do
    if [ $i -ge 10 ]
    then
	pkill -KILL java
	sleep 1
	break
    fi
    i=$((i+1))
    sleep 1
done
