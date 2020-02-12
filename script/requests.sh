#!/bin/bash

eval $(egrep -v '^#' .env | xargs)

echo "
[req]
default_bits = 2048
distinguished_name = dn
prompt             = no

[dn]
C=\"US\"
ST=\"Florida\"
OU=\"Service\"
emailAddress=\"admin@${HOST}\"
CN=\"${HOST}\"

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.0 = ${HOST}
DNS.1 = *.${HOST}
DNS.2 = *.docker.${HOST}
" > certs/csr.conf
