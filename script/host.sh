#!/bin/bash

eval $(egrep '^HOST' .env | xargs)
echo "127.0.0.1	${HOST}" | sudo tee -a /etc/hosts
echo "127.0.0.1	dashboard.${HOST}" | sudo tee -a /etc/hosts