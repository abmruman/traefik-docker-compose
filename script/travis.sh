#!/bin/bash

set -eux

./script/cert.sh
./script/host.sh
./script/build.sh
./script/test.sh
./script/cleanup.sh
