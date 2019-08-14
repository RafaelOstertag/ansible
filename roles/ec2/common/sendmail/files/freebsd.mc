divert(0)
VERSIONID(`$FreeBSD: releng/12.0/etc/sendmail/freebsd.mc 285230 2015-07-07 03:00:57Z gshapiro $')
OSTYPE(freebsd6)

dnl Set Hostname
define(`confDOMAIN_NAME',`guengel.ch')dnl
DAEMON_OPTIONS(`Name=IPv4, Family=inet, Addr=127.0.0.1')dnl
DAEMON_OPTIONS(`Name=IPv6, Family=inet6, Modifiers=O, Addr=::1')dnl
DAEMON_OPTIONS(`Name=IPv4-MSA, Family=inet, Addr=127.0.0.1, Port=587, M=E')dnl
DAEMON_OPTIONS(`Name=IPv6-MSA, Family=inet6, Addr=::1, Port=587, M=E')dnl
FEATURE(`nullclient', `gizmo.kruemel.home')dnl
