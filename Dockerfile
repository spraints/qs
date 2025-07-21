FROM ruby:2.6.10 AS bundled

RUN apt-get update && apt-get install -y nodejs
RUN gem install rubygems-update -v 3.4.22 && update_rubygems && gem update --system

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

FROM bundled

COPY . .

RUN bin/rails assets:precompile

CMD ["bundle", "exec", "unicorn", "-p", "3000", "-c", "config/unicorn.rb"]
