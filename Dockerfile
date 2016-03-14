FROM ruby:2.3.0-slim

# Run updates and install basics
# build-essential: Compile specific gems
# libpq-dev: Communicate with postgresql through pg
# git-core: Checkout git repos
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  git-core

# Node.js
RUN apt-get install -y nodejs nodejs-legacy npm

# Bower
RUN npm install -g bower

# Clean apt
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up app directory
RUN mkdir -p /app
WORKDIR /app

# Install gems, use cache if possible
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install --jobs 20 --retry 3 --standalone --clean --without development test

# Install bower packages, use cache if possible
COPY bower.json ./
RUN bower install --allow-root

# Copy application code
COPY . /app

# Precompile Rails assets, use temporary secret key base
RUN bundle exec rake assets:resolve RAILS_ENV=production SECRET_KEY_BASE=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
RUN bundle exec rake assets:precompile RAILS_ENV=production SECRET_KEY_BASE=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
