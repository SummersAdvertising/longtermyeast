require 'capistrano/ext/multistage'
require 'bundler/capistrano' 				#Using bundler with Capistrano

#set :stages, %w(staging production)
#set :default_stage, "production"

set :stages, %w(staging production)
set :default_stage, "production"

default_run_options[:pty] = true

after 'deploy:sym_link', 'localize:munge_environment'
namespace :localize do
  desc 'munge environment.rb to set staging environment'
  task :munge_environment, :roles => [:app] do
    new_env = "ENV['RAILS_ENV'] = 'development'\n" + File.read(Rails.root.join('config', 'environment.rb'))
    put new_env, "#{current_path}/config/environment.rb"
  end
end
