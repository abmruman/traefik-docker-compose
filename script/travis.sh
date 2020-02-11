#!/bin/bash

set -eux

./script/init.sh
./script/cert.sh
./script/host.sh
./script/build.sh
./script/test.sh
./script/cleanup.sh
