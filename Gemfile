# source 'https://ruby.taobao.org'
source 'https://rubygems.org'

gem 'rails', '4.2.0'

# Search And Database
gem 'pg'
gem 'pg_search', '~> 0.7.0', git: 'https://github.com/pathsource/pg_search.git'

# Frontend Gem
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'
gem 'compass-rails', '~> 2.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.3.5'

# misc
gem 'kaminari', '~> 0.15.1'
gem 'nokogiri'
gem 'rabl-rails'
gem 'devise'

gem 'geocoder'


group :development do
  gem 'better_errors', '~> 1.1.0'
  gem 'binding_of_caller', '~> 0.7.1'
  gem 'thin', '~> 1.5.1'
  gem 'mina', git: 'https://github.com/pathsource/mina.git'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'minitest'
  gem 'faker', '~> 1.2.0'
  gem 'fabrication'
  gem 'minitest-stub_any_instance'
end

group :production do
end