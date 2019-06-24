#!/bin/sh

if [ $# -ne 1 ]
then
    echo "`basename $0` <jarfile>"
    exit 1
fi

/usr/sbin/daemon -p /opt/app/var/app.pid -P /opt/app/var/supervisor.pid -f /usr/local/openjdk8/bin/java -Xmx128m ${JAVA_OPTS} -jar "$1"
