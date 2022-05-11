; Maintained by Ansible
$ORIGIN guengel.ch.
$TTL 6h    ; 6 hours
@            IN     SOA    optimusprime.guengel.ch. postmaster.guengel.ch. (
                    202205110 ; serial
                    1d        ; Refresh
                    1h        ; Retry
                    1w        ; Expire
                    1h        ; Negative Cache TTL
                    )
             IN     NS      optimusprime.kruemel.home.
                    NS      viking.kruemel.home.
                    A       192.168.103.3
                    AAAA    fd3e:be3e:ec34:1::3
                    MX      10 colossus.guengel.ch.

gargoyle     IN     A       192.168.100.254
                    AAAA    fd3e:be3e:ec34:0::2

colossus     IN     A       192.168.100.2
                    AAAA    fd3e:be3e:ec34:0::3

viking       IN     A       192.168.100.4
                    AAAA    fd3e:be3e:ec34:0::4

optimusprime IN     A       192.168.100.5
                    AAAA    fd3e:be3e:ec34:0::5

yayap        IN     A       192.168.103.2
                    AAAA    fd3e:be3e:ec34:1::2

www          IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
imap         IN     CNAME   colossus.guengel.ch.
smtp         IN     CNAME   ec2-52-57-75-84.eu-central-1.compute.amazonaws.com.
yapet        IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
agentsmith   IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
portscanner  IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
sso          IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
funnel       IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
memberberry  IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
astro        IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
photos       IN     CNAME   ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
ssh          IN     CNAME   yayap.guengel.ch.
vpn          IN     CNAME   yayap.wlan.kruemel.home.
