#!/bin/sh

trap "rm -f vaultpass" EXIT

echo "Enter vault password"
stty -echo
read password
stty echo

echo "$password" > vaultpass
unset password

for f in freebsd-servers.yml freebsd-workstations.yml openbsd-servers.yml openbsd-virtual-hosts. solaris11-servers.yml solaris11-workstations.yml
do
    ansible -i hosts --vault-password-file=vaultpass "$f"
done
