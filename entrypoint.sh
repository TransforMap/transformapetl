#!/usr/bin/env sh

cd /usr/src/app/

if [ ! -f /usr/src/app/transformap.conf ]; then
  echo "Generating configuration"
  /bin/sh -c "envsubst '$$POSTGRES_USER $$POSTGRES_PASS $$POSTGRES_DB $$POSTGRES_HOST' < /usr/src/app/transformap.example.conf > /usr/src/app/transformap.conf"
fi

make setupdb
#make runserver
/usr/src/app/.env/bin/python manage.py runserver 0.0.0.0:80

