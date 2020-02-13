#!/bin/bash
set -ev

docker-compose config
docker-compose pull
docker-compose up -d
docker-compose ps
