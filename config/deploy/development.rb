url = ENV.fetch("STAGING_URL")
port = ENV.fetch("STAGING_PORT")
user = ENV.fetch("STAGING_USER")

server url, roles: %w{app web db}, user: user, post: port, :primary => true

set :app_name, ENV.fetch("DB_MAIN_NAME")
set :application, ENV.fetch("DB_MAIN_NAME")
set :deploy_to, "/opt/dev/#{ fetch(:app_name) }"

set :branch,     'master'
set :rails_env,  'dev'
set :deploy_env, 'dev'

# Allow deploy of specific branches
set :branch, ENV['BRANCH'] if ENV['BRANCH']
