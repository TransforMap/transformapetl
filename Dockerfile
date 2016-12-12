FROM python:2.7-alpine

ENV POSTGRES_USER tfm
ENV POSTGRES_PASSWORD password
ENV POSTGRES_HOST localhost
ENV POSTGRES_DB tfm

# https://github.com/google/cadvisor/issues/1131#issuecomment-240705787
# https://github.com/creationix/nvm/issues/1064
RUN apk add --update openssl tar
# https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md#example
RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    postgresql-dev \
    gettext \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*
# pg_config needed for psycogs2 build during pip install belo# pg_config needed for psycogs2 build during pip install below

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV VERSION docker
ENV DEBUG 1
RUN wget https://github.com/TransforMap/transformapetl/archive/${VERSION}.tar.gz \
  -O source.tgz

RUN tar xfzv source.tgz --strip-components=1

RUN [ -d .env ] || virtualenv .env
RUN .env/bin/pip install -r requirements.txt

COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
COPY ./transformap.example.conf /usr/src/app/transformap.example.conf

EXPOSE 80
CMD [ /usr/src/app/.env/bin/python, manage.py, runserver, 0.0.0.0:80 ]
