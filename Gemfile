# frozen_string_literal: true

source 'https://rubygems.org'

platform :jruby do
  gem 'jruby-openssl', '~> 0.9.8', require: false
end

group :test do
  gem 'rspec'
end

group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
