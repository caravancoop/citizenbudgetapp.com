source 'https://rubygems.org'
ruby '2.3.3'

gem 'rails', '4.2.5.1'
gem 'actionpack-action_caching'
gem 'rails-i18n'
gem 'dotenv-rails'

gem 'cancan'
gem 'devise'
gem 'google-api-client', '~> 0.6.4', require: 'google/api_client'
gem 'jwt', '~> 0.1.4' # google-api-client
gem 'mustache'

# Server
gem 'unicorn'

# Database
gem 'pg'
gem 'paranoia', '~> 2.0'

# Admin
gem 'activeadmin', '1.0.0'

# I18n
gem 'devise-i18n'
gem 'i18n-timezones'

# Image uploads
gem 'fog', '1.34.0'
gem 'mini_magick'
gem 'carrierwave'
gem 'mime-types'
gem 'sprockets-rails', :require => 'sprockets/railtie'

# Views
gem 'haml-rails'
gem 'rdiscount'
gem 'unicode_utils'
gem 'bourgeois'

# Export
gem 'docx'
gem 'net-ssh', '2.9.2'
gem 'spreadsheet'
gem 'axlsx', '2.1.0.pre'
gem 'rubyzip', '1.1.7'

# Heroku API
gem 'oj'
gem 'multi_json'
gem 'faraday'

# Rake
gem 'ruby-progressbar'

# Middleware
gem 'rack-timeout'    # Abort requests that are taking too long
gem 'rack-revision'   # Adds a revision number to the request's header
gem 'rack-protection' # Protects against typical web attacks
gem 'rack-attack'     # Handles blocking & throttling

# Reporting
gem 'skylight'
gem 'sentry-raven'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'therubyracer', require: 'v8'
    gem 'libv8', '3.16.14.7'
  end
  gem 'bootstrap-sass' 
  gem 'sass-rails', '~> 5.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'byebug'

  gem 'factory_girl_rails'
  gem 'ffaker'

  gem 'brakeman', require: false
  gem 'dawnscanner', require: false
end

# For maintenance scripts to run in development console.
group :development do
  gem 'mechanize'
  gem 'odf-report'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'foreman'
  end

  # Error logging
  gem 'airbrake', '~> 3.1.15'
  gem 'rails_12factor'
  gem 'lograge'
end

group :migrate do
  gem 'mongoid'
  gem 'redis'
  gem 'bulk_insert'
end
