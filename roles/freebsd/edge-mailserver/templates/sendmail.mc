divert(-1)
Maintained by Ansible.

$Id$
divert(0)dnl

VERSIONID(`$Id$')dnl
OSTYPE(freebsd6)
DOMAIN(generic)

dnl Set Hostname
define(`confDOMAIN_NAME',`{{ external_name }}')dnl

FEATURE(access_db, `hash -o -T<TMPF> /etc/mail/access')
FEATURE(blacklist_recipients)
dnl FEATURE(local_lmtp)
FEATURE(mailertable, `hash -o /etc/mail/mailertable')
FEATURE(virtusertable, `hash -o /etc/mail/virtusertable')
FEATURE(`use_cw_file')dnl
FEATURE(`use_ct_file')dnl
dnl
dnl Bounce messages addressed to "address.REDIRECT".  This allows the
dnl admin to alias a user who has moved to "new_address.REDIRECT" so
dnl that senders will know the user's new address.
FEATURE(redirect)dnl


dnl Make the daemon listen on smtp and ssmtp
DAEMON_OPTIONS(`Name=MTA, Family=inet, Port=smtp')dnl
DAEMON_OPTIONS(`Name=MTA-SSL, Family=inet, Port=smtps, M=s')dnl
DAEMON_OPTIONS(`Name=MTA-IPv6, Family=inet6, Port=smtp')dnl
DAEMON_OPTIONS(`Name=MTA-IPv6, Family=inet6, Port=submission')dnl
DAEMON_OPTIONS(`Name=MTA-SSL-IPv6, Family=inet6, Port=smtps, M=s')dnl

undefine(`BITNET_RELAY')dnl
undefine(`UUCP_RELEAY')dnl
define(`confCOPY_ERRORS_TO',`postmaster')dnl
define(`confTO_QUEUERETURN',`7d')dnl
define(`confTO_QUEUEWARN',`4h')dnl
define(`confTO_IDENT',`0s')dnl
define(`confPRIVACY_FLAGS', `authwarnings,needmailhelo,noexpn,novrfy,nobodyreturn')dnl
define(`confDELIVERY_MODE',`background')dnl
define(`confBAD_RCPT_THROTTLE',`6')dnl
define(`confDONT_BLAME_SENDMAIL',`GroupReadableKeyFile')dnl

dnl # 2007-05-09 added by tux
dnl # Load average settings and other stuff
define(`confQUEUE_LA', 10)dnl
define(`confDELAY_LA', 20)dnl
define(`confREFUSE_LA', 26)dnl
define(`confMAX_DAEMON_CHILDREN', `25')dnl
define(`confREJECT_LOG_INTERVAL',`1h')dnl
define(`confCONNECTION_RATE_THROTTLE', `3')dnl
define(`confBAD_RCPT_THROTTLE', `3')dnl
define(`confMAX_QUEUE_CHILDREN', `10')dnl
define(`confALLOW_BOGUS_HELO', `False')dnl

dnl Enable STARTTLS for receiving email.
define(`CERT_DIR', `/etc/mail/tls')dnl
define(`confSERVER_CERT', `CERT_DIR/host.cert')dnl
define(`confSERVER_KEY', `CERT_DIR/host.key')dnl
define(`confCRL', `/etc/ssl/guengel.ch.crl')dnl   # <= EDIT
define(`confCLIENT_CERT', `CERT_DIR/host.cert')dnl
define(`confCLIENT_KEY', `CERT_DIR/host.key')dnl
define(`confCACERT', `/etc/ssl/guengel.ch.pem')dnl
define(`confCACERT_PATH', `/etc/ssl/certs')dnl
define(`confDH_PARAMETERS', `CERT_DIR/dh.param')dnl
define(`confTLS_SRV_OPTIONS', `')dnl   # <= EDIT

dnl hosting and virtual stuff
MASQUERADE_AS(`guengel.ch')dnl
MASQUERADE_DOMAIN(`kruemel.home')dnl
FEATURE(`masquerade_entire_domain')dnl
FEATURE(`always_add_domain')dnl
FEATURE(`masquerade_envelope')dnl

INPUT_MAIL_FILTER(`clamav', `S=local:/var/run/clamav/clmilter.sock, F=, T=S:4m;R:4m')dnl
dnl this is from clamav-milter.conf
define(`confMILTER_MACROS_EOM', `{msg_id}, {mail_addr}, {rcpt_addr}, i')dnl
INPUT_MAIL_FILTER(`spamassassin', `S=local:/var/run/spamass-milter.sock, F=, T=C:15m;S:4m;R:4m;E:10m')dnl
define(`confMILTER_MACROS_ENVRCPT',confMILTER_MACROS_ENVRCPT`, b, r, v, Z')dnl

define(`confINPUT_MAIL_FILTERS', `clamav,spamassassin')dnl

# Enable authentication
define(`confAUTH_MECHANISMS', `DIGEST-MD5 CRAM-MD5 LOGIN PLAIN')dnl
FEATURE(`authinfo',`hash /etc/mail/auth/client-info')dnl	   	 

dnl Antispam section
FEATURE(`nouucp', `reject')dnl
FEATURE(`blacklist_recipients')dnl
FEATURE(`enhdnsbl', `zen.spamhaus.org', `"550 Access denied. Spam."')dnl
FEATURE(`enhdnsbl', `bl.spamcop.net', `"500 Access denied. Spam."', `t')dnl
dnl FEATURE(`dnsbl',`dnsbl.sorbs.net',`"554 Rejected " $&{client_addr} " found in dnsbl.sorbs.net"')dnl 

dnl Smart host added 2010-05-09
define(`SMART_HOST',`[smtpauth.bluewin.ch]')dnl
define(`LOCAL_RELAY',`esmtp:gizmo.kruemel.home')dnl
MAILER(`smtp')dnl
dnl
dnl
dnl Enforce valid Message-Id to help stop spammers.
dnl
LOCAL_RULESETS
HMessage-Id: $>CheckMessageId

SCheckMessageId
R< $+ @ $+ >		$@ OK
R$*			$#error $: 553 Header Error
