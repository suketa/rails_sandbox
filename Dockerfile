FROM ruby:3.3.4

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV RUBY_YJIT_ENABLE 1

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  postgresql-client \
  default-mysql-client \
  tzdata \
  vim-tiny \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
  export NVM_DIR="$HOME/.nvm" && \
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
  nvm install 20.17.0 && \
  npm install -g npm && \
  npm install -g yarn

RUN gem install rails -v 7.2.1

WORKDIR /app
