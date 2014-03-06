source 'https://rubygems.org'

ruby '2.1.0'

# rails
gem 'rails'

# everything else
gem 'dotenv'
gem 'haml-rails'
gem 'omniauth-openid'
gem 'unicorn'


# not production
group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'guard-rspec'
  gem 'spring'
end

group :test do
  gem 'factory_girl_rails'
end


# production
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
