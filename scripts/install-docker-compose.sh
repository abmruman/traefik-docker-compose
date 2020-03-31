#!/bin/bash
set -ex

if [ -z "$DOCKER_COMPOSE_VERSION" ]; then
    DOCKER_COMPOSE_VERSION=1.25.4
fi

echo "Installing docker-compose version: $DOCKER_COMPOSE_VERSION"

if [ -z "`sudo -l 2>/dev/null`" ]; then

    rm /usr/local/bin/docker-compose | echo
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
    chmod +x docker-compose
    mv docker-compose /usr/local/bin
else
    sudo rm /usr/local/bin/docker-compose | echo
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
    sudo chmod +x docker-compose
    sudo mv docker-compose /usr/local/bin
fi
