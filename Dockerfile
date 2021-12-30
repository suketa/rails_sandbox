FROM ruby:3.0.2-alpine3.14

ENV LANG C.UTF-8
# ENV ROOTPATH /app

# RUN mkdir $ROOTPATH
# WORKDIR $ROOTPATH

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual=.build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      postgresql-dev \
      mysql-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    apk add --update --no-cache \
      bash \
      nodejs \
      npm \
      git \
      openssh \
      postgresql-client \
      mysql-client \
      tzdata \
      yaml
RUN npm install -g npm && \
    npm install -g yarn && \
    gem install bundler && \
    gem install rails -v 7.0.0

# for rails webpacker
# RUN npm install -g yarn

WORKDIR /app
