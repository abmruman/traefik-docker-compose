#!/bin/bash

echo "Copying env file"
cp env.example .env

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
docker network create web | echo

echo "docker-compose"
docker-compose config
docker-compose pull
echo "starting the services"
docker-compose up -d
docker-compose ps


# printf "\n\nWaiting for things to start"
# x=0
# while [ $x -le 10 ]
# do
#   printf "."
#   sleep 1
#   x=$(( $x + 1 ))
# done
# echo "."