set :application, 	"longtermyeast"
set :domain, 		"li406-49.members.linode.com"
set :repository, 	"git@github.com:SummersAdvertising/longtermyeast.git"
set :deploy_to,		"/var/spool/RoR-Projects/longtermyeast"

role :app,		domain
role :web,	domain
role :db, 		domain,	:primary => true

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :user, "apps"
set :password, "1qaz2wsx"
set :group, "webs"

default_environment["PATH"] = "/opt/ree/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

desc "precompile the assets"
task :precompile_assets, :roles => :web, :except => { :no_release => true } do
	run "cd #{current_path}; rm -rf public/assets/*"
	run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end

namespace :deploy do
	desc "restart"
	task :restart do		
		run "cd #{current_path}; RAILS_ENV=production bundle exec rake cache:clear"
	end
end

desc "Create database.yml and asset packages for production"
after("deploy:update_code") do
	#db_config = "#{shared_path}/config/database.yml.production"
	#db_config = "#{db_config} #{release_path}/config/database.yml.production"
	#run "cp #{db_config} #{release_path}/config/database.yml"	
end

