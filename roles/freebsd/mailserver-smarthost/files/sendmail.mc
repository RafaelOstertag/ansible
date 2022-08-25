divert(-1)
###
### Maintained by Ansible
###
#
# Copyright (c) 1983 Eric P. Allman
# Copyright (c) 1988, 1993
#	The Regents of the University of California.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#	This product includes software developed by the University of
#	California, Berkeley and its contributors.
# 4. Neither the name of the University nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

#
#  This is a generic configuration file for FreeBSD 6.X and later systems.
#  If you want to customize it, copy it to a name appropriate for your
#  environment and do the modifications there.
#
#  The best documentation for this .mc file is:
#  /usr/share/sendmail/cf/README or
#  /usr/src/contrib/sendmail/cf/README
#

divert(0)
VERSIONID(`$Id$')dnl
OSTYPE(freebsd6)dnl
DOMAIN(generic)dnl

FEATURE(access_db, `hash -T<TMPF> /etc/mail/access')dnl
FEATURE(blacklist_recipients)dnl
FEATURE(local_lmtp)dnl
FEATURE(mailertable, `hash -o /etc/mail/mailertable')dnl
FEATURE(virtusertable, `hash -o /etc/mail/virtusertable')dnl

dnl Dialup users should uncomment and define this appropriately
define(`SMART_HOST', `smtp-1')dnl

define(`confCW_FILE', `/etc/mail/local-host-names')dnl

dnl Enable for both IPv4 and IPv6 (optional)
DAEMON_OPTIONS(`Name=MTA, Family=inet, Port=smtp')dnl
DAEMON_OPTIONS(`Name=MTA-SSL, Family=inet, Port=smtps, M=s')dnl
DAEMON_OPTIONS(`Name=MTA-IPv6, Family=inet6, Port=smtp')dnl
DAEMON_OPTIONS(`Name=MTA-SSL-IPv6, Family=inet6, Port=smtps, M=s')dnl

define(`confCACERT_PATH',     `/etc/ssl')dnl
define(`confCACERT',           `/etc/ssl/guengel.ch.pem')dnl
define(`confCRL',              `/etc/ssl/guengel.ch.crl')dnl
define(`confSERVER_CERT',     `/etc/mail/tls/server.cert')dnl
define(`confSERVER_KEY',      `/etc/mail/tls/server.key')dnl
define(`confCLIENT_CERT',     `/etc/mail/tls/client.cert')dnl
define(`confCLIENT_KEY',      `/etc/mail/tls/client.key')dnl
define(`confTLS_SRV_OPTIONS', `')dnl
define(`confDONT_BLAME_SENDMAIL',`GroupReadableKeyFile')dnl

define(`confAUTH_REALM', `colossus')dnl
define(`confAUTH_MECHANISMS',`LOGIN PLAIN')dnl
TRUST_AUTH_MECH(`LOGIN PLAIN')dnl

define(`confBIND_OPTS', `WorkAroundBrokenAAAA')
define(`confNO_RCPT_ACTION', `add-to-undisclosed')
define(`confPRIVACY_FLAGS', `authwarnings,noexpn,novrfy')
undefine(`BITNET_RELAY')dnl
undefine(`UUCP_RELEAY')dnl
undefine(`LOCAL_RELAY')dnl
define(`confCOPY_ERRORS_TO',`postmaster')dnl
define(`confTO_QUEUERETURN',`1w')dnl
define(`confTO_QUEUEWARN',`4h')dnl
define(`confTO_IDENT',`0s')dnl
define(`confPRIVACY_FLAGS',`noexpn,novrfy,needmailhelo,noreceipts,goaway')dnl
define(`confMAX_DAEMON_CHILDREN', '50')dnl
define(`confDELIVERY_MODE',`background')dnl
define(`confBAD_RCPT_THROTTLE',`6')dnl
dnl this makes sure we use tls/ssl when issuing login/plain auth
define(`confAUTH_OPTIONS',`p')dnl

FEATURE(`always_add_domain')dnl
FEATURE(`use_cw_file')dnl
dnl As of 2013-07-01, mails from root@xxxx.kruemel.home to
dnl root@xxxx.kruemel.home suddenly started being relayed to
dnl bluewin (NO FREAKING CLUE WHY!). So, instead of adding each
dnl host to local-host-names again, we employ this.
FEATURE(`bestmx_is_local', `kruemel.home')dnl

MASQUERADE_AS(`guengel.ch')dnl
MASQUERADE_DOMAIN(`kruemel.home')dnl
MASQUERADE_EXCEPTION(`rafaelostertag.photo')dnl
MASQUERADE_EXCEPTION(`ostertag.dev')dnl
FEATURE(`masquerade_entire_domain')dnl
FEATURE(`masquerade_envelope')dnl

EXPOSED_USER(`root')dnl
FEATURE(`nouucp', `reject')dnl
define(`CYRUSV2_MAILER_ARGS', `FILE /var/imap/socket/lmtp')dnl
define(`confLOCAL_MAILER', `cyrusv2')dnl
MAILER(`cyrusv2')dnl
MAILER(`smtp')dnl
LOCAL_CONFIG
dnl# Do not allow SSLv2 and weak ciphers:dnl
O CipherList=TLSv1.2:+HIGH:!MEDIUM:!LOW:!NULL:!ADH:!EXP
