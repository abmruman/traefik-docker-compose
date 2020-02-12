#!/bin/bash

set -e

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

shopt -s expand_aliases
alias curl="curl -ILsS -X GET"
alias grep="grep -C 100 --color=auto"
alias echo="echo -e"

eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^DASHBOARD_HOST' .env | xargs)

echo "\n\nTesting Traefik........................\n"
echo "\nHOST=${HOST}"
echo "\nDASHBOARD_HOST=${DASHBOARD_HOST}\n"


echo "\n\nRediection test........................\n"
echo "\nhttp://${HOST}\n"
curl http://${HOST} | grep 302 || exit 1
echo "\nhttp://${HOST}\n"
curl http://${DASHBOARD_HOST} | grep  302 || exit 1

# echo "\n\nAuthentication test....................\n"

echo "\n\nAuthentication test....................\n"
echo "\nhttps://user:pass@${DASHBOARD_HOST}\n"
curl -f --anyauth -u user:pass https://${DASHBOARD_HOST} | grep 200 || exit 1

echo "\nhttps://user:pass@${DASHBOARD_HOST}/dashboard/\n"
curl -f --anyauth -u user:pass https://${DASHBOARD_HOST}/dashboard/ | grep 200 || exit 1
echo "\n\n.......................................\n"
