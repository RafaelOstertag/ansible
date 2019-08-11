#!/bin/sh
#
# Create letsencrypt certificates
#

set -e

/usr/local/bin/certbot \
    certonly --webroot -w /data/www/nginx-letsencrypt \
    -d {{ nginx_domains | join(' -d ') }} \
    -d {{ nginx_custom_domains | join(' -d ') }}
service nginx restart
