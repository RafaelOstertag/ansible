#!/bin/sh
#
# Create letsencrypt certificates
#
/usr/local/bin/certbot \
    certonly --webroot -w /data/www/nginx-letsencrypt \
    -d {{ nginx_domains |join(' -d ') }} 