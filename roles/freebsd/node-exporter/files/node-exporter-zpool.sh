#!/bin/sh

ZPOOL=/sbin/zpool
if [ ! -f "${ZPOOL}" ]
then
    echo "${ZPOOL} not found" 1>&2
    exit 1
fi

${ZPOOL} list -Hp | while read name size alloc free ckpoint expandsz frag cap dedup health rest
do
    echo "# HELP zpool_size size in bytes of zpool"
    echo "# TYPE zpool_size gauge"
    echo "zpool_size{name=\"$name\"} $size"

    echo "# HELP zpool_allocated allocated bytes of zpool"
    echo "# TYPE zpool_allocated gauge"
    echo "zpool_allocated{name=\"$name\"} $alloc"

    echo "# HELP zpool_free free bytes of zpool"
    echo "# TYPE zpool_free gauge"
    echo "zpool_free{name=\"$name\"} $free"

    echo "# HELP zpool_healthy flag indicating if zpool is health"
    echo "# TYPE zpool_healthy gauge"
    if [ "${health}" == "ONLINE" ]
    then
        healthy=1
    else
        healthy=0
    fi

    echo "zpool_healthy{name=\"$name\"} $healthy"
done
