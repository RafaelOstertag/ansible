divert(-1)
Maintained by Ansible.
divert(0)dnl

VERSIONID(`$Id: submit.mc, v 8.12.3-6.4 2003-04-25 15:16:27 cowboy Exp $')
define(`__OSTYPE__',`')dnl dirty hack to keep proto.m4 from complaining
define(`confDOMAIN_NAME',`smtp.guengel.ch')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # Masquerading information, if needed, should go here
dnl # You likely will not need this, as the MTA will do it
dnl #---------------------------------------------------------------------
dnl MASQUERADE_AS()dnl
dnl FEATURE(`masquerade_envelope')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # The real reason we're here: the FEATURE(msp)
dnl #---------------------------------------------------------------------
FEATURE(`msp', `[127.0.0.1]', `MSA')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # Some minor cleanup from FEATURE(msp)
dnl #---------------------------------------------------------------------
dnl #
dnl #---------------------------------------------------------------------
define(`confDONT_BLAME_SENDMAIL',`GroupReadableKeyFile')dnl
define(`confTO_STARTTLS',     `2m')dnl   # <= EDIT

# define(`CERT_DIR', `/etc/mail/tls')dnl
# define(`confSERVER_CERT', `CERT_DIR/host.cert')dnl
# define(`confSERVER_KEY', `CERT_DIR/host.key')dnl
# define(`confCRL', `/etc/ssl/guengel.ch.crl')dnl   # <= EDIT
# define(`confCLIENT_CERT', `CERT_DIR/host.cert')dnl
# define(`confCLIENT_KEY', `CERT_DIR/host.key')dnl
# define(`confCACERT', `/etc/ssl/guengel.ch.pem')dnl
# define(`confCACERT_PATH', `/etc/ssl/certs')dnl
# define(`confDH_PARAMETERS', `CERT_DIR/dh.param')dnl
# define(`confTLS_SRV_OPTIONS', `')dnl   # <= EDIT
