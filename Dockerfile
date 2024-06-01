FROM ruby:3.3.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV RUBY_YJIT_ENABLE 1

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  postgresql-client \
  default-mysql-client \
  sqlite3 \
  nodejs \
  npm \
  tzdata \
  vim \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g npm && \
    npm install -g yarn && \
    gem install rails -v 7.1.3

WORKDIR /app
