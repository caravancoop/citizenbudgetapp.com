source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.1'
gem 'rails-i18n'

gem 'dotenv-rails'


# Database
gem 'mongoid', '5.1'

# Admin
gem 'formtastic', '~> 2.2.1'
gem 'inherited_resources', '~> 1.4.1'
gem 'sass', '~> 3.2.14'
gem 'activeadmin-mongoid', '0.3.0'
gem 'activeadmin', '1.0.0.pre2'
gem 'cancan'
gem 'devise', '~> 2.1.3' # 2.2 is backwards-incompatible
gem 'devise-i18n'
gem 'mustache', '~> 0.99.0'
gem 'google-api-client', '0.9'
gem 'jwt'

# Image uploads
gem 'fog'
gem 'rmagick'
gem 'carrierwave-mongoid'

# Views
gem 'haml-rails'
gem 'rdiscount'
gem 'unicode_utils'

# Export
gem 'spreadsheet'
gem 'axlsx', '2.1.0.pre'
gem 'rubyzip', '>= 1.0.0'

# Heroku API
gem 'oj'
gem 'multi_json'
gem 'faraday'

# Rake
gem 'ruby-progressbar'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'therubyracer', require: 'v8'
    gem 'libv8', '3.16.14.7'
  end

  gem 'sass-rails', '~> 5.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'

# For maintenance scripts to run in development console.
group :development do
  gem 'mechanize'
  gem 'pry-rails'
  gem 'odf-report'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
end
group :production do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'foreman'
  end

gem 'unicorn'
  # Error logging
  gem 'airbrake', '~> 3.1.15'
  gem 'rails_12factor'

  # Performance
  gem 'action_dispatch-gz_static'
  gem 'memcachier'
  gem 'dalli'

  # Heroku deployments
  if ENV['HEROKU']
    gem 'newrelic_rpm'
  end
end
