source 'https://rubygems.org'

ruby '2.4.4'
gem 'rails', '5.0.7.2'

# assets
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'

# everything else
gem 'dotenv'
gem 'omniauth-google-oauth2', '>= 0.6.0'
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
  gem 'pg', '~> 0.18' # AR's pg adapter says this
  gem 'rails_12factor'
end
