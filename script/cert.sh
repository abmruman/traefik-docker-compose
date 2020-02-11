#!/bin/bash

eval $(egrep '^HOST' .env | xargs)
echo "Domain: ${HOST}"
echo "Creating Cert"
openssl req -x509 -out certs/localhost.crt -keyout certs/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj "/CN=${HOST}" -extensions EXT -config <( \
   printf "[dn]\nCN=*.${HOST}\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:*.localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

openssl rsa:2048 -in certs/localhost.key -out certs/localhost.pem -pubout -outform PEM
sudo cp certs/localhost.key /usr/local/share/ca-certificates/localhost.pem
sudo ln -s /usr/local/share/ca-certificates/localhost.pem /etc/ssl/certs/localhost.pem
sudo update-ca-certificates
