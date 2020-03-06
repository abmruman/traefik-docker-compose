#!/bin/bash
set -e

echo "Copying env file"
# Create env from env.example if it doesn't exist
if [ -f ".env" ]
then
  echo -e "env file exists"
else
  echo -e "Copying env file"
  cp env.example .env
fi

echo "creating acme.json"
touch acme.json
chmod 600 acme.json

echo "creating provider.key"
touch provider.key
echo "supersecretkey" | tee provider.key
chmod 600 provider.key

printf "Creating network: "
eval $(egrep '^NETWORK' .env | xargs)
printf "$NETWORK\n"
docker network create $NETWORK | echo
