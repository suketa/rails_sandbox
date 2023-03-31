FROM ruby:3.2.2

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs npm

RUN npm install -g yarn

WORKDIR /app
