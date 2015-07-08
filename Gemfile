source 'https://rubygems.org'
ruby "2.1.5"

gem 'rails', '4.1.8'
gem 'mysql2', '0.3.17'
gem 'rolify'
gem 'cancancan', '~> 1.9'
gem "paranoia", "~> 2.0"
gem 'devise'
gem 'devise-async',                          '0.9.0'
gem 'delayed_job_active_record',             '4.0.2'
gem 'therubyracer'
gem 'best_in_place', github: 'bernat/best_in_place'
gem 'activeadmin', github: 'activeadmin'
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass',                        '3.2.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails',                       '5.0.3'
gem 'turbolinks'
gem 'has_secure_token' # This will be included in Rails 5
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'bcrypt', '~> 3.1.7'
gem 'state_machine', '1.2.0'
gem 'jquery-datetimepicker-rails'
gem 'acts-as-taggable-on',                   '~> 3.4'
gem 'rails4-autocomplete'
gem 'rabl-rails'
gem "paperclip", '4.2.0'
gem 'rb-readline'
gem "auto_strip_attributes", "~> 2.0"
gem "audited-activerecord", "~> 4.0"
gem 'aws-sdk'
gem "just-datetime-picker"
gem 'posix-spawn'
gem 'rack-cors'
gem 'exception_notification'
gem 'jquery-fileupload-rails'
gem 'puma'
gem 'jsonapi-resources'

gem 'daemons', group: :staging
group :development do
  gem 'capistrano3-delayed-job', '~> 1.0'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-unicorn-nginx'
  gem 'quiet_assets'
  gem 'byebug'
  gem 'letter_opener'
  gem 'pry'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec'
  gem "rspec-rails", '~> 2.14.0.rc1'
  gem 'shoulda-matchers', require: false
  gem 'shoulda'
  gem 'capybara'
  gem 'faker'
end

group :production, :staging do
  gem "unicorn"
end

gem 'rails_12factor', group: :production

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use unicorn as the app server
# gem 'unicorn'

