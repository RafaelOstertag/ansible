#!/bin/sh

if [ $# -lt 1 ]
then
    echo "`basename $0` <executable> [arg1 ... argN]"
    exit 1
fi

/usr/sbin/daemon -p /opt/app/var/app.pid -P /opt/app/var/supervisor.pid -f "$@"
