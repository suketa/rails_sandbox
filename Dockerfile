FROM ruby:3.2.2

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential nodejs npm vim \
    libpq-dev postgresql-client \
    default-libmysqlclient-dev default-mysql-client

WORKDIR /app
