#!/bin/bash
set -e

eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^CERT_PATH' .env | xargs)

echo "Domain: ${HOST}"
echo "Cert Path: ${CERT_PATH}"

if [ -f certs/cert.crt ] || [ -f certs/cert.key ] || [ -f certs/cert.pem ]; then
  echo -e "cert already exists in certs directory\nDo you want to overwrite the files? [y]es/[n]o"
  read -r ANSWER
  echo
  if [[ "$ANSWER" =~ ^[Yy](es)?$ ]] ; then
    echo "Creating Cert"
  else
    exit 1
  fi
fi

./scripts/requests.sh

openssl genrsa -out $CERT_PATH/cert.key
openssl req -new -key $CERT_PATH/cert.key -out $CERT_PATH/cert.csr -config $CERT_PATH/csr.conf
openssl x509 -req -days 365 -in $CERT_PATH/cert.csr -signkey $CERT_PATH/cert.key -out $CERT_PATH/cert.crt -extensions req_ext -extfile $CERT_PATH/csr.conf

sudo cp $CERT_PATH/cert.crt /usr/local/share/ca-certificates/cert.crt
sudo rm -f /usr/local/share/ca-certificates/certificate.crt
# --fresh is needed to remove symlinks to no-longer-present certificates
sudo update-ca-certificates --fresh
