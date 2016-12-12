#!/usr/bin/env bash

cd /usr/src/app/

if [ ! -f /usr/src/app/transformap.conf ]; then
  echo "Generating configuration"
  /bin/bash -c "envsubst < /django/transformap.example.conf > /usr/src/app/transformap.conf"
fi

make setupdb
#make runserver
/usr/src/app/.env/bin/python runserver 0.0.0.0:80

