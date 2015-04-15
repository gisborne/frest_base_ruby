source 'https://rubygems.org'

gem 'dotenv'
gem 'foreman', require: false
gem 'puma', require: false

gem 'rake', require: false

gem 'activerecord', '~> 4.2.0', require: 'active_record'
gem 'pg'

group :development, :test do
  gem 'pry'
  gem 'shotgun'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
end

group :documentation do
  gem 'yard', require: false
end