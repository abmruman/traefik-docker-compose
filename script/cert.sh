#!/bin/bash

eval $(egrep '^HOST' .env | xargs)
eval $(egrep '^CERT_PATH' .env | xargs)

echo "Domain: ${HOST}"
echo "Cert Path: ${CERT_PATH}"

echo "Creating Cert"
./script/requests.sh

openssl genrsa -out $CERT_PATH/cert.key
openssl req -new -key $CERT_PATH/cert.key -out $CERT_PATH/cert.csr -config $CERT_PATH/csr.conf
openssl x509 -req -days 365 -in $CERT_PATH/cert.csr -signkey $CERT_PATH/cert.key -out $CERT_PATH/cert.crt -extensions req_ext -extfile $CERT_PATH/csr.conf

sudo cp $CERT_PATH/cert.crt /usr/local/share/ca-certificates/cert.crt
sudo rm -f /usr/local/share/ca-certificates/certificate.crt
# --fresh is needed to remove symlinks to no-longer-present certificates
sudo update-ca-certificates --fresh
