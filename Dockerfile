FROM ruby:3.4.10

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential nodejs npm vim \
    git libvips pkg-config \
    curl libsqlite3-0 \
    libpq-dev postgresql-client libvips \
    default-libmysqlclient-dev default-mysql-client \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
