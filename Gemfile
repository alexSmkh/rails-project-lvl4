# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'aasm', '~> 5.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'faker'
gem 'jbuilder', '~> 2.7'
gem 'omniauth'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-rails_csrf_protection'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
gem 'rollbar', '~> 3.3'
gem 'sass-rails', '>= 6'
gem 'simple_form', '~> 5.1'
gem 'slim', '~> 4.1'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'prettier', '~> 2.0'
  gem 'rubocop', '~> 1.26'
  gem 'rubocop-performance', '~> 1.13'
  gem 'rubocop-rails', '~> 2.13'
  gem 'slim_lint', '~> 0.22.1'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'bullet'
  gem 'html2slim'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'minitest-power_assert', '~> 0.3.1'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
