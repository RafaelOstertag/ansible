divert(0)dnl
VERSIONID(`$FreeBSD: releng/12.0/etc/sendmail/freebsd.submit.mc 285230 2015-07-07 03:00:57Z gshapiro $')
define(`confCF_VERSION', `Submit')dnl
define(`__OSTYPE__',`')dnl dirty hack to keep proto.m4 from complaining
define(`_USE_DECNET_SYNTAX_', `1')dnl support DECnet
define(`confTIME_ZONE', `USE_TZ')dnl
define(`confDONT_INIT_GROUPS', `True')dnl
define(`confBIND_OPTS', `WorkAroundBrokenAAAA')dnl
dnl
dnl If you use IPv6 only, change [127.0.0.1] to [IPv6:::1]
MASQUERADE_AS(`guengel.ch')
MASQUERADE_DOMAIN(`freebsd')
FEATURE(masquerade_entire_domain)
FEATURE(masquerade_envelope)
FEATURE(`msp', `[127.0.0.1]')dnl
