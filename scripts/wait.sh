#!/bin/bash

x="$1"
[[ -z "$x" ]] && x=5

printf "\n\nWaiting for things to start"
while [ $x -gt 0 ]
do
  printf "."
  sleep 1
  x=$(( $x - 1 ))
done
echo "."
