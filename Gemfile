source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Make sure the Ruby versions on your development and production servers are the same
# The app will fail faster if the wrong version of Ruby is installed
ruby "2.6.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1.4"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Use Puma as the app server
gem "puma", "~> 3.12"

# API Documentation - by swagger
gem "rswag"

# The rspec gem needs to be out of the test group because of rswag
# The documentation is based on rspec tests
gem "rspec-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Capistrano for deployment
group :deployment do
  gem "capistrano",            "~> 3.10.2", require: false
  gem "capistrano-bundler",    "~> 1.2", require: false
  gem "capistrano-rails",      "~> 1.3", require: false
  gem "capistrano-rvm",        "~> 0.1.2", require: false
  gem "capistrano3-puma",      "~> 3.1.1", require: false
end

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
gem "rack-attack"
gem "rack-cors", require: "rack/cors"

# Load environment variables from .env
gem "dotenv"
gem "dotenv-rails"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # https://github.com/rubocop-hq/rubocop
  gem "rubocop", require: false
  gem "rubocop-rspec"

  # https://github.com/presidentbeef/brakeman
  gem "brakeman"
end

group :development do
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # https://github.com/voormedia/rails-erd
  # http://graphviz.org
  gem "rails-erd"
end

group :test do
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
  gem "json_schema"
  gem "rack-test", require: "rack/test"
  gem "simplecov"
  gem "vcr"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# https://github.com/rocketjob/rails_semantic_logger
gem "rails_semantic_logger"
