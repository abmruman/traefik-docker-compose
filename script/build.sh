#!/bin/bash

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