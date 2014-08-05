source 'https://rubygems.org'


gem 'rails', '4.1.4'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'formtastic', ">= 2.3.0.rc2"
gem 'mail'
gem 'valid_email'

gem 'jquery-cdn', '2.1.1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'spring',        group: :development

gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'silent-postgres'
  gem 'unicorn', platform: :ruby
end

gem 'pg', platform: :ruby
gem 'dalli'

platform :jruby do
  gem 'activerecord-jdbcpostgresql-adapter'
end

group :development, :test do
  gem 'minitest-spec-rails'
end

group :production do
  gem 'exception_notification', git: 'git://github.com/pcantrell/exception_notification'
  gem 'therubyracer'
end
