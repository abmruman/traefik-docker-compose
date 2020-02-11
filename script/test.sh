#!/bin/bash

set -eux

eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^DASHBOARD_HOST' .env | xargs)

shopt -s expand_aliases
alias curlf="curl -kILSs --connect-timeout 5 --max-time 5 --retry 5 --retry-delay 5 --retry-max-time 30"

echo "Testing container..."
echo "HOST=${HOST}"
echo "DASHBOARD_HOST=${DASHBOARD_HOST}"
echo "rediection test........................"
(curlf http://${HOST} | grep '307' && true) || exit 1
echo "Unauth user test......................."
(curlf https://${DASHBOARD_HOST} | grep '401' && true) || exit 1
echo "Authentication test...................."
(curlf -u user:pass https://${DASHBOARD_HOST} | grep '405' && true) || exit 1
echo "......................................."
(curlf -u 'user:pass' https://${DASHBOARD_HOST}/dashboard/ | grep '405' && true) || exit 1
# curlf -u 'user:pass' https://${DASHBOARD_HOST}/dashboard/
echo "......................................."
