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
gem 'uglifier'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'faker'
end

group :production, :staging do
  gem 'rails_12factor'
  gem "aws-sdk-s3", require: false
end
