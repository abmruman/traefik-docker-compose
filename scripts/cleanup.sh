#!/bin/bash

echo "Cleaning up..."
docker-compose down

printf "Deleting  network: "
eval $(egrep '^NETWORK' .env | xargs)
printf "$NETWORK\n"
docker network rm $NETWORK | echo
