source 'https://rubygems.org'

gem 'rails', '3.2.6'

group :assets do
  gem 'sass-rails',   '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'bootstrap-sass', '~> 2.1.0.0'
  gem 'bootswatch-rails', git: "git://github.com/maxim/bootswatch-rails.git"

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem "capybara", :group => [:development, :test]
gem "devise"
gem "haml", ">= 3.0.0"
gem "haml-rails"

gem 'inherited_resources'
gem 'simple_form'
gem 'nested_form'
gem 'kaminari'

gem "tabs_on_rails"

gem 'acts-as-taggable-on'

gem "pg"

group :development do
  gem 'mail_view', git: 'https://github.com/37signals/mail_view.git'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'shoulda-matchers'
  gem 'mocha'
  gem 'capybara-webkit'
  gem 'email_spec'
  gem 'database_cleaner'
  gem 'faker'

  gem 'debugger'
  gem 'pry'

  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'mysql2'
  gem 'spork-rails'
end