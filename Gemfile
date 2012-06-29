source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.6'

# Error logging
gem 'airbrake'
gem 'heroku'

# Performance
group :production do
  gem 'dalli'
  gem 'newrelic_rpm'
end

# Background jobs
gem 'girl_friday'

# Database
gem 'bson_ext'
gem 'mongoid'

# Admin
gem 'activeadmin', git: 'git://github.com/gregbell/active_admin.git'
gem 'activeadmin-mongoid'
gem 'devise'
gem 'mustache'
gem 'cancan'

# Image uploads
gem 'fog'
gem 'rmagick'
gem 'carrierwave-mongoid'

# Views
gem 'haml-rails'
gem 'rdiscount'
gem 'unicode_utils'

# Heroku API
gem 'oj'
gem 'multi_json'
gem 'faraday'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
end

gem 'unicorn'
