#!/bin/sh

set -eu

err_out() {
    echo "$*" >&2
}

if [ `id -un` != "borg" ]
then
    err_out "Must be run as user 'borg'"
    exit 1
fi

REPOSITORIES="`ls -d /var/borg/repos/*/*`"

for r in ${REPOSITORIES}
do
    echo "### Check repository '$r'"
    time borg check -v "$r"
    echo "### Done"
done