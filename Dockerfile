FROM ruby:3.4.6

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential nodejs npm vim \
    git libvips pkg-config \
    curl libsqlite3 \
    libpq-dev postgresql-client \
    default-libmysqlclient-dev default-mysql-client
WORKDIR /app
