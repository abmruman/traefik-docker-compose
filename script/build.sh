#!/bin/bash

echo "docker-compose"
docker-compose config
docker-compose pull
echo "starting the services"
docker-compose up -d
docker-compose ps
