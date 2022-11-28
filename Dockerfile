FROM ruby:2.6.10 AS bundled

RUN apt-get update && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

FROM bundled

COPY . .

RUN bin/rails assets:precompile

CMD ["bundle", "exec", "unicorn", "-p", "3000", "-c", "config/unicorn.rb"]
