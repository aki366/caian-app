source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.0.3"

gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
gem 'bootstrap-sass'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker'
gem 'turbolinks', '~> 5'
gem 'jbuilder'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'uglifier'
gem 'pry-rails'
gem 'jquery-rails'
gem 'bcrypt'
gem "image_processing", ">= 1.2"
gem 'mini_magick'

group :development, :test do
  gem 'rspec-rails', '~> 3.6'
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen'
  gem 'pre-commit'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
