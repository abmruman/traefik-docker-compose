#!/bin/bash
set -ev

eval $(egrep '^HOST' .env | xargs)

if [ "$HOST" != "localhost" ]; then
    grep "127.0.0.1	${HOST}" /etc/hosts || (echo "127.0.0.1	${HOST}" | sudo tee -a /etc/hosts)
fi
grep "127.0.0.1	docker.${HOST}" /etc/hosts || (echo "127.0.0.1	docker.${HOST}" | sudo tee -a /etc/hosts)
grep "127.0.0.1	dashboard.${HOST}" /etc/hosts || (echo "127.0.0.1	dashboard.${HOST}" | sudo tee -a /etc/hosts)
