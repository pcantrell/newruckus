source 'https://rubygems.org'

gem 'rails', '~> 4.1'

gem 'pg', '~> 0.2', platform: :ruby
gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0'
gem 'haml-rails'
gem 'formtastic', ">= 2.3"
gem 'mail'
gem 'valid_email'
gem 'dalli'
gem 'jbuilder', '~> 2.0'

gem 'jquery-cdn', '~> 2.1'
gem 'jquery-rails'
gem 'turbolinks'

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'devise', '>= 3.2.0'

gem 'bcrypt', '~> 3.1'

gem 'delayed_job_active_record'
gem 'daemons'
gem 'mailchimp-api', require: 'mailchimp'

group :development do
  gem 'spring'
  gem 'letter_opener'
end

group :development, :test do
  gem 'unicorn', platform: :ruby
  gem 'minitest-spec-rails'
  gem 'factory_girl_rails'
end

group :production do
  gem 'exception_notification', git: 'git://github.com/pcantrell/exception_notification'
  gem 'therubyracer'
end
