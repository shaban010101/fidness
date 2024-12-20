# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'pg'
gem 'pry'
gem 'bcrypt'
gem 'rails', '~> 6.0.0'
gem 'bootsnap', require: false
gem 'listen'
gem 'devise'
gem 'grape'
gem 'sidekiq'
gem 'faker'
gem 'mini_magick'
gem 'active_storage_validations'
gem 'sass'
gem 'pry-byebug'
gem 'webpacker',  '~> 4.2.2'
gem 'stripe'
gem 'nokogiri', '~> 1.10.4'
gem 'react-rails'
gem 'twilio-ruby', '~> 5.39.2'
gem 'uglifier'
gem 'money-rails'
gem 'jquery-rails'

group :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner-active_record'
end

group :production, :staging do
  gem 'rails_12factor'
  gem "aws-sdk-s3", require: false
  gem 'puma'
end
