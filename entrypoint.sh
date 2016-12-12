#!/usr/bin/env sh

cd /usr/src/app/

if [ ! -f /usr/src/app/transformap.conf ]; then
  echo "Generating configuration"
  envsubst '${POSTGRES_USER},${POSTGRES_PASSWORD},${POSTGRES_DB},${POSTGRES_HOST}' < /usr/src/app/transformap.example.conf > /usr/src/app/transformap.conf
fi

make setupdb
#make runserver
/usr/src/app/.env/bin/python manage.py runserver 0.0.0.0:80

