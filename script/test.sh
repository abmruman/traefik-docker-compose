#!/bin/bash

set -eux

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^DASHBOARD_HOST' .env | xargs)

shopt -s expand_aliases
alias curls="curl -ILSs"

echo "Testing container..."

echo "HOST=${HOST}"
echo "DASHBOARD_HOST=${DASHBOARD_HOST}"

echo "rediection test........................"
(curls http://${HOST} | grep '307') || exit 1

echo "Unauth user test......................."
(curls https://${DASHBOARD_HOST} | grep '401') || exit 1

echo "Authentication test...................."
(curls -u 'user:pass' https://${DASHBOARD_HOST} | grep '405') || exit 1

echo "......................................."
(curls -u 'user:pass' https://${DASHBOARD_HOST}/dashboard/ | grep '405') || exit 1
echo "......................................."
