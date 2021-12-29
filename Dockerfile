FROM ruby:2.3.5-alpine3.4

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
      sqlite-dev \
      mysql-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    apk add --update --no-cache \
      bash \
      nodejs \
      git \
      openssh \
      postgresql-client \
      mysql-client \
      tzdata \
      yaml
Run gem install bundler -v 1.17.3 && \
    gem install racc -v 1.5.2 && \
    gem install nokogiri -v 1.10.10 && \
    gem install sprockets -v 3.7.2 && \
    gem install rails -v 4.2.11.3

# for rails webpacker
# RUN npm install -g yarn

WORKDIR /app
