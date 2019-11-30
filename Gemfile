source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Repository for collecting Locale data for Ruby on Rails I18n as well as other 
# interesting, Rails related I18n stuff
gem 'rails-i18n', '~> 5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Token based authentication for Rails JSON APIs. Designed to work with jToker and ng-token-auth.
gem 'devise_token_auth'
# A plugin for versioning Rails based RESTful APIs.
gem 'versionist'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers', '~> 0.10.0'
# Manage Procfile-based applications http://ddollar.github.com/foreman
gem 'foreman'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari'
# Declaratively filter data via URL params, in any Rack app, with any ORM.
gem 'rack-reducer'
# High performance memcached client for Ruby
gem 'dalli'
# CLI and Ruby client library for Travis CI
gem 'travis'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'
  # Rails >= 3 pry initializer
  gem 'pry-rails'
  # RSpec for Rails-3+ http://relishapp.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.9.0'
end

group :production do
  # A PostgreSQL client library for Ruby
  gem 'pg', '~> 1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
