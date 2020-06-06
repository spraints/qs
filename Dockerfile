FROM ruby:2.6.6

RUN apt-get update && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
