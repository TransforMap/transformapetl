#!/usr/bin/env bash

cd /django/

if [ ! -f /django/transformap.conf ]; then
  echo "Generating configuration"
  /bin/bash -c "envsubst < /django/transformap.example.conf > /django/transformap.conf"
fi

make setupdb
make runserver
