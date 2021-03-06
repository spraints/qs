FROM ruby:2.6.6 AS bundled

RUN apt-get update && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

FROM bundled

COPY . .
