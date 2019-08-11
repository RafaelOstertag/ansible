divert(0)
VERSIONID(`$FreeBSD: releng/12.0/etc/sendmail/freebsd.mc 285230 2015-07-07 03:00:57Z gshapiro $')
OSTYPE(freebsd6)
DOMAIN(generic)

FEATURE(access_db, `hash -o -T<TMPF> /etc/mail/access')
FEATURE(blacklist_recipients)
FEATURE(local_lmtp)
FEATURE(mailertable, `hash -o /etc/mail/mailertable')
FEATURE(virtusertable, `hash -o /etc/mail/virtusertable')
MASQUERADE_AS(`guengel.ch')
MASQUERADE_DOMAIN(`freebsd')
FEATURE(masquerade_entire_domain)
FEATURE(masquerade_envelope)

dnl Enable STARTTLS for receiving email.
define(`CERT_DIR', `/etc/mail/certs')dnl
define(`confSERVER_CERT', `CERT_DIR/host.cert')dnl
define(`confSERVER_KEY', `CERT_DIR/host.key')dnl
define(`confCLIENT_CERT', `CERT_DIR/host.cert')dnl
define(`confCLIENT_KEY', `CERT_DIR/host.key')dnl
define(`confCACERT', `CERT_DIR/cacert.pem')dnl
define(`confCACERT_PATH', `CERT_DIR')dnl
define(`confDH_PARAMETERS', `CERT_DIR/dh.param')dnl

dnl Uncomment to allow relaying based on your MX records.
dnl NOTE: This can allow sites to use your server as a backup MX without
dnl       your permission.
dnl FEATURE(relay_based_on_MX)

dnl DNS based black hole lists
dnl --------------------------------
dnl DNS based black hole lists come and go on a regular basis
dnl so this file will not serve as a database of the available servers.
dnl For more information, visit
dnl http://en.wikipedia.org/wiki/DNSBL

dnl Uncomment to activate your chosen DNS based blacklist
dnl FEATURE(dnsbl, `dnsbl.example.com')
dnl Alternatively, you can provide your own server and rejection message:
dnl FEATURE(dnsbl, `dnsbl.example.com', ``"550 Mail from " $&{client_addr} " rejected"'')

dnl Dialup users should uncomment and define this appropriately
define(`SMART_HOST', `gizmo.kruemel.home')

dnl Uncomment the first line to change the location of the default
dnl /etc/mail/local-host-names and comment out the second line.
dnl define(`confCW_FILE', `-o /etc/mail/sendmail.cw')
define(`confCW_FILE', `-o /etc/mail/local-host-names')

dnl Enable for both IPv4 and IPv6 (optional)
DAEMON_OPTIONS(`Name=IPv4, Family=inet')
DAEMON_OPTIONS(`Name=IPv6, Family=inet6, Modifiers=O')

define(`confBIND_OPTS', `WorkAroundBrokenAAAA')
define(`confNO_RCPT_ACTION', `add-to-undisclosed')
define(`confPRIVACY_FLAGS', `authwarnings,noexpn,novrfy')
MAILER(local)
MAILER(smtp)
