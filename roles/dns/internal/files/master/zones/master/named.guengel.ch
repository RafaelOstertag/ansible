; Maintained by Ansible
$TTL 6h	; 6 hours
@	IN SOA	optimusprime.guengel.ch. postmaster.guengel.ch. (
				201908102; serial
				3h	; refresh
				1h	; retry
				1w	; expire
				1h	; minimum
				)
@		IN	A	192.168.103.3
			AAAA	fd3e:be3e:ec34:1::3
guengel.ch.		13654	IN	NS	optimusprime.kruemel.home.
guengel.ch.		13654	IN	NS	viking.kruemel.home.
		IN	MX	10 gizmo.guengel.ch.
gargoyle	IN	A	192.168.100.254
			AAAA	fd3e:be3e:ec34:0::2
gizmo		IN	A	192.168.100.1
			AAAA	fd3e:be3e:ec34:0::1
viking		IN	A	192.168.100.4
			AAAA	fd3e:be3e:ec34:0::4
optimusprime	IN	A	192.168.100.5
			AAAA	fd3e:be3e:ec34:0::5
starscream	IN	A	192.168.103.4
			AAAA	fd3e:be3e:ec34:1::4
megatron	IN	A	192.168.100.7
			AAAA	fd3e:be3e:ec34::7
eventhorizon	IN	A	192.168.103.3
			AAAA	fd3e:be3e:ec34:1::3
yayap		IN	A	192.168.103.2
			AAAA	fd3e:be3e:ec34:1::2
www		IN	CNAME	ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
webmail		IN	CNAME	eventhorizon.guengel.ch.
imap		IN	CNAME	gizmo.guengel.ch.
smtp		IN	CNAME	starscream.guengel.ch.
bugs		IN	CNAME	eventhorizon.guengel.ch.
solaris		IN	CNAME	eventhorizon.guengel.ch.
yapet		IN	CNAME	eventhorizon.guengel.ch.
agentsmith	IN	CNAME	ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
portscanner 	IN	CNAME	eventhorizon.guengel.ch.
jenkins		IN	CNAME	ec2-52-29-59-221.eu-central-1.compute.amazonaws.com.
ssh		IN	CNAME	yayap.guengel.ch.
vpn		IN	CNAME	yayap.wlan.kruemel.home.
