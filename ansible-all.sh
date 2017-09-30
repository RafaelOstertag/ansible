#!/bin/sh

trap "rm -f vaultpass" EXIT

echo "Enter vault password"
stty -echo
read password
stty echo

echo "$password" > vaultpass
unset password

echo "Commencing run"

for f in freebsd-servers.yml freebsd-workstations.yml openbsd-servers.yml openbsd-virtual-hosts.yml
do
    ansible-playbook -f 20 -i hosts --vault-password-file=vaultpass "$f"
done
