#!/bin/sh
#
# $Id$

pkg update -f
pkg upgrade -y
pkg clean -y

for f in /usr/local/etc/rc.d/*
do
    $f stop
done

services=`rcorder /usr/local/etc/rc.d/* 2>/dev/null`
for f in ${services}
do
    $f start
done

