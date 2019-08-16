divert(-1)
Maintained by Ansible.

divert(0)dnl

VERSIONID(`$Id$')dnl
OSTYPE(freebsd6)
DOMAIN(generic)

dnl Set Hostname
define(`confDOMAIN_NAME',`smtp.guengel.ch')dnl

FEATURE(access_db, `hash -o -T<TMPF> /etc/mail/access')
FEATURE(mailertable, `hash -o /etc/mail/mailertable')
FEATURE(virtusertable, `hash -o /etc/mail/virtusertable')
FEATURE(`use_cw_file')dnl
dnl FEATURE(`use_ct_file')dnl
dnl
dnl Bounce messages addressed to "address.REDIRECT".  This allows the
dnl admin to alias a user who has moved to "new_address.REDIRECT" so
dnl that senders will know the user's new address.
FEATURE(redirect)dnl

DAEMON_OPTIONS(`Name=MTA, Family=inet, Port=smtp')dnl

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

define(`confQUEUE_LA', 5)dnl
define(`confDELAY_LA', 10)dnl
define(`confREFUSE_LA', 15)dnl
define(`confMAX_DAEMON_CHILDREN', `25')dnl
define(`confREJECT_LOG_INTERVAL',`1h')dnl
define(`confCONNECTION_RATE_THROTTLE', `3')dnl
define(`confBAD_RCPT_THROTTLE', `3')dnl
define(`confMAX_QUEUE_CHILDREN', `10')dnl
define(`confALLOW_BOGUS_HELO', `False')dnl

dnl Enable STARTTLS for receiving email.
define(`confCRL', `/etc/ssl/guengel.ch.crl')dnl   # <= EDIT
define(`confCACERT_PATH', `/etc/ssl/certs')dnl
define(`CERT_DIR', `/usr/local/etc/letsencrypt/live/smtp.guengel.ch')dnl
define(`confSERVER_CERT', `CERT_DIR/fullchain.pem')dnl
define(`confSERVER_KEY', `CERT_DIR/privkey.pem')dnl
define(`confCLIENT_CERT', `CERT_DIR/fullchain.pem')dnl
define(`confCLIENT_KEY', `CERT_DIR/privkey.pem')dnl
dnl define(`confCACERT', `/etc/ssl/guengel.ch.pem')dnl

# define(`confDH_PARAMETERS', `CERT_DIR/dh.param')dnl
# define(`confTLS_SRV_OPTIONS', `')dnl   # <= EDIT

dnl hosting and virtual stuff
MASQUERADE_AS(`guengel.ch')dnl
MASQUERADE_DOMAIN(`kruemel.home')dnl
FEATURE(`masquerade_entire_domain')dnl
FEATURE(`always_add_domain')dnl
FEATURE(`masquerade_envelope')dnl

INPUT_MAIL_FILTER(`clamav', `S=local:/var/run/clamav/clmilter.sock, F=, T=S:4m;R:4m')dnl
INPUT_MAIL_FILTER(`spamassassin', `S=local:/var/run/spamass-milter.sock, F=, T=C:15m;S:4m;R:4m;E:10m')dnl
INPUT_MAIL_FILTER(`dkim-filter', `S=local:/var/run/milteropendkim/dkim.sock, F=, T=R:2m')dnl

dnl this is from clamav-milter.conf
define(`confMILTER_MACROS_EOM', `{msg_id}, {mail_addr}, {rcpt_addr}, i')dnl
define(`confMILTER_MACROS_ENVRCPT',confMILTER_MACROS_ENVRCPT`, b, r, v, Z')dnl
define(`confINPUT_MAIL_FILTERS', `clamav,spamassassin,dkim-filter')dnl

dnl Antispam section
FEATURE(`nouucp', `reject')dnl
FEATURE(`blacklist_recipients')dnl
FEATURE(`enhdnsbl', `zen.spamhaus.org', `"550 Access denied. Spam."')dnl
FEATURE(`enhdnsbl', `bl.spamcop.net', `"500 Access denied. Spam."', `t')dnl

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
