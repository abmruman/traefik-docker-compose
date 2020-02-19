#!/bin/bash
set -ev

if [ -z "$DOCKER_COMPOSE_VERSION" ]; then
    DOCKER_COMPOSE_VERSION=1.25.4
fi

echo "Installing docker-compose version: $DOCKER_COMPOSE_VERSION"

sudo rm /usr/local/bin/docker-compose | echo
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo chmod +x docker-compose
sudo mv docker-compose /usr/local/bin
