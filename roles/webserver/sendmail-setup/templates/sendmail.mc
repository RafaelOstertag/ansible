divert(-1)
#
#
# !!!! This file is maintained by Ansible !!!!
#
divert(0)dnl
VERSIONID(`$Id: sendmail.mc 7087 2017-09-11 20:02:57Z rafi $')dnl
OSTYPE(freebsd6)dnl
FEATURE(`no_default_msa')dnl
FEATURE(access_db, `hash -T<TMPF> /etc/mail/access')dnl
DAEMON_OPTIONS(`Name=IPv6, Family=inet6, Modifiers=O, Addr={{ jail_loIP }}')dnl
DAEMON_OPTIONS(`Name=IPv6-MSA, Family=inet6, Addr={{ jail_loIP }}, Port=587, M=E')dnl
define(`confBIND_OPTS', `WorkAroundBrokenAAAA')
define(`confNO_RCPT_ACTION', `add-to-undisclosed')
define(`confPRIVACY_FLAGS', `authwarnings,noexpn,novrfy')
define(`confDONT_BLAME_SENDMAIL',`GroupReadableKeyFile')dnl
define(`confCACERT_PATH',       `/etc/mail/tls')dnl
define(`confCACERT',           `/etc/ssl/guengel.ch.pem')dnl
define(`confCRL',              `/etc/ssl/guengel.ch.crl')dnl
define(`confSERVER_CERT',     `/etc/mail/tls/server.cert')dnl
define(`confSERVER_KEY',      `/etc/mail/tls/server.key')dnl
define(`confCLIENT_CERT',     `/etc/mail/tls/client.cert')dnl
define(`confCLIENT_KEY',      `/etc/mail/tls/client.key')dnl
define(`confTLS_SRV_OPTIONS', `')dnl
define(`confTO_IDENT', `0s')dnl
FEATURE(`nullclient', `gizmo.kruemel.home')dnl
LOCAL_CONFIG
dnl# Do not allow SSLv2 and weak ciphers:dnl
O CipherList=TLSv1.2:TLSv1:+HIGH:!MEDIUM:!LOW:!NULL:!ADH:!EXP
