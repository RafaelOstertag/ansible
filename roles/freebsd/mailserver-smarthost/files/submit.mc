divert(-1)
###
### Maintained by Ansible
###
#
# Copyright (c) 2001-2003 Sendmail, Inc. and its suppliers.
#	All rights reserved.
#
# By using this file, you agree to the terms and conditions set
# forth in the LICENSE file which can be found at the top level of
# the sendmail distribution.
#
#

#
#  This is the FreeBSD configuration for a set-group-ID sm-msp sendmail
#  that acts as a initial mail submission program.
#

divert(0)dnl
VERSIONID(`$Id$')
define(`confCF_VERSION', `Submit')dnl
define(`__OSTYPE__',`')dnl dirty hack to keep proto.m4 from complaining
define(`_USE_DECNET_SYNTAX_', `1')dnl support DECnet
define(`confTIME_ZONE', `USE_TZ')dnl
define(`confDONT_INIT_GROUPS', `True')dnl
define(`confBIND_OPTS', `WorkAroundBrokenAAAA')dnl
define(`confCACERT_PATH',     `/etc/ssl')dnl
define(`confCACERT',           `/etc/ssl/guengel.ch.pem')dnl
define(`confCRL',              `/etc/ssl/guengel.ch.crl')dnl
define(`confSERVER_CERT',     `/etc/mail/tls/server.cert')dnl
define(`confSERVER_KEY',      `/etc/mail/tls/server.key')dnl
define(`confCLIENT_CERT',     `/etc/mail/tls/client.cert')dnl
define(`confCLIENT_KEY',      `/etc/mail/tls/client.key')dnl
define(`confTLS_SRV_OPTIONS', `')dnl
define(`confDONT_BLAME_SENDMAIL', `GroupReadableKeyFile')dnl
dnl
dnl If you use IPv6 only, change [127.0.0.1] to [IPv6:::1]
FEATURE(`msp', `[IPv6:::1]')dnl
LOCAL_CONFIG
dnl# Do not allow SSLv2 and weak ciphers
O CipherList=TLSv1.2:TLSv1:+HIGH:!MEDIUM:!LOW:!NULL:!ADH:!EXP
