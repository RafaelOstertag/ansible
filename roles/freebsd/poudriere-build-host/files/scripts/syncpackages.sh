#!/bin/sh
rsync --password-file /root/poudriere/syncpackages.password -aP --delete /usr/poudriere/data/packages/ poudriere@colossus.kruemel.home::packages/