#!/bin/sh

cd /usr/src/lib/libsmutil
make cleandir && make obj && make
cd /usr/src/lib/libsm
make cleandir && make obj && make
cd /usr/src/usr.sbin/sendmail
make cleandir && make obj && make && make install
service sendmail restart
