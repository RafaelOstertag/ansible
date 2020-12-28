#!/bin/sh

set -eu

ZPOOL=/sbin/zpool
if [ ! -f "${ZPOOL}" ]
then
    echo "${ZPOOL} not found" 1>&2
    exit 1
fi

SIZE=""
ALLOCATED=""
FREE=""
HEALTHY=""
OLDIFS="${IFS}"
IFS=$'
'
for l in `${ZPOOL} list -Hp`
do
    name=`echo $l | awk '{ print $1 }'`
    size=`echo $l | awk '{ print $2 }'`
    alloc=`echo $l | awk '{ print $3 }'`
    free=`echo $l | awk '{ print $4 }'`
    health=`echo $l | awk '{ print $10 }'`
    SIZE="${SIZE}zpool_size{name=\"$name\"} $size\n"
    ALLOCATED="${ALLOCATED}zpool_allocated{name=\"$name\"} $alloc\n"
    FREE="${FREE}zpool_free{name=\"$name\"} $free\n"

    if [ "${health}" == "ONLINE" ]
    then
        healthy=1
    else
        healthy=0
    fi

    HEALTHY="${HEALTHY}zpool_healthy{name=\"$name\"} $healthy\n"
done
IFS="${OLDIFS}"

if [ -n "${SIZE}" ]
then
    echo "# HELP zpool_size size in bytes of zpool"
    echo "# TYPE zpool_size gauge"
    echo -e "$SIZE" | sed '/^$/d'
fi
if [ -n "${ALLOCATED}" ]
then
    echo "# HELP zpool_allocated allocated bytes of zpool"
    echo "# TYPE zpool_allocated gauge"
    echo -e "$ALLOCATED" | sed '/^$/d'
fi
if [ -n "${FREE}" ]
then
    echo "# HELP zpool_free free bytes of zpool"
    echo "# TYPE zpool_free gauge"
    echo -e "$FREE" | sed '/^$/d'
fi
if [ -n "${HEALTHY}" ]
then
    echo "# HELP zpool_healthy flag indicating if zpool is health"
    echo "# TYPE zpool_healthy gauge"
    echo -e "$HEALTHY" | sed '/^$/d'
fi
