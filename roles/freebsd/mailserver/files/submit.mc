divert(-1)
#
# $Id$
#
# !!!! This file is maintained by Ansible !!!!
#
divert(0)dnl
VERSIONID(`$Id$')dnl
define(`confCF_VERSION', `Submit')dnl
define(`__OSTYPE__',`')dnl dirty hack to keep proto.m4 from complaining
define(`_USE_DECNET_SYNTAX_', `1')dnl support DECnet
define(`confTIME_ZONE', `USE_TZ')dnl
define(`confDONT_INIT_GROUPS', `True')dnl
define(`confBIND_OPTS', `WorkAroundBrokenAAAA')dnl
dnl
dnl If you use IPv6 only, change [127.0.0.1] to [IPv6:::1]
FEATURE(`msp', `[IPv6:::1]')dnl
define(`confDONT_BLAME_SENDMAIL',`GroupReadableKeyFile')dnl
define(`confCACERT_PATH',       `/etc/mail/tls')dnl
define(`confCACERT',           `/etc/ssl/guengel.ch.pem')dnl
define(`confCRL',              `/etc/ssl/guengel.ch.crl')dnl
define(`confSERVER_CERT',     `/etc/mail/tls/server.cert')dnl
define(`confSERVER_KEY',      `/etc/mail/tls/server.key')dnl
define(`confCLIENT_CERT',     `/etc/mail/tls/client.cert')dnl
define(`confCLIENT_KEY',      `/etc/mail/tls/client.key')dnl
define(`confTLS_SRV_OPTIONS', `')dnl
LOCAL_CONFIG
dnl# Do not allow SSLv2 and weak ciphers:dnl
O CipherList=TLSv1.2:TLSv1:+HIGH:!MEDIUM:!LOW:!NULL:!ADH:!EXP
