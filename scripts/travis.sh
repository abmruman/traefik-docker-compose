#!/bin/bash
set -ev

./scripts/init.sh
./scripts/cert.sh
./scripts/host.sh
./scripts/build.sh
./scripts/wait.sh ${WAIT_FOR}
./scripts/test.sh
