#!/bin/bash

./script/init.sh
./script/cert.sh
./script/host.sh
./script/build.sh
./script/wait.sh ${WAIT_FOR}
./script/test.sh
