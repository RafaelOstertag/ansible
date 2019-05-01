#!/bin/sh

pkill java
i=0
while pgrep java
do
	if [ i -ge 10 ]
	then
		pkill -KILL java
		break
	fi
	i=$((i+1))
	sleep 1
done
