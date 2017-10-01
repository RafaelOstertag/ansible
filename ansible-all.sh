#!/bin/sh

echo "Commencing run"

for f in freebsd-servers.yml freebsd-workstations.yml openbsd-servers.yml openbsd-virtual-hosts.yml
do
    ansible-playbook -f 20 "$f"
done
