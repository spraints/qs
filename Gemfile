source 'https://rubygems.org'

ruby '2.4.0'
gem 'rails', '4.1.0rc1'

# assets
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

# everything else
gem 'dotenv'
gem 'haml-rails'
gem 'omniauth-google-oauth2'
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
