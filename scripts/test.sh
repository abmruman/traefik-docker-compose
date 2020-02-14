#!/bin/bash

set -e

export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

source ./scripts/color.sh

shopt -s expand_aliases
alias curl="curl -ILsS -X GET"
alias grep="grep -C 100 --color=auto"
alias echo="echo -e \${RESET}"


eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^DASHBOARD_HOST' .env | xargs)

echo "\n\n${YELLOW_BACK}${RED}Testing Traefik........................${RESET}\n"
echo "\nHOST=${HOST}"
echo "\nDASHBOARD_HOST=${DASHBOARD_HOST}\n"


echo "\n\n${YELLOW}Rediection test........................${RESET}\n"
echo "\n${GREEN}http://${HOST}${RESET}\n"
curl http://${HOST} | grep 302 || exit 1
echo "\n${GREEN}http://${HOST}${RESET}\n"
curl http://${DASHBOARD_HOST} | grep  302 || exit 1

# echo "\n\nAuthentication test....................\n"

echo "\n\n${YELLOW}Authentication test....................${RESET}\n"
echo "\n${GREEN}https://user:pass@${DASHBOARD_HOST}${RESET}\n"
curl -f --anyauth -u user:pass https://${DASHBOARD_HOST} | grep 200 || exit 1

echo "\n${GREEN}https://user:pass@${DASHBOARD_HOST}/dashboard/${RESET}\n"
curl -f --anyauth -u user:pass https://${DASHBOARD_HOST}/dashboard/ | grep 200 || exit 1
echo "\n\n${GREEN}.......................................${RESET}\n"
