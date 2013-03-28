set :stages, %w(production)
set :default_stage, "production"

#require "rvm/capistrano"
require "bundler/capistrano"

require 'capistrano/ext/multistage'

#require "whenever/capistrano"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

role :web, "198.211.106.13"                     # Your HTTP server, Apache/etc
role :app, "198.211.106.13"                     # This may be the same as your `Web` server
role :db,  "198.211.106.13", :primary => true   # This is where Rails migrations will run

set :application, "website"
set :user, "root"
#set :password, "ubzlvsoovnij"
#set :deploy_via, :remote_cache
set :deploy_via, :checkout
set :use_sudo, false
set :rails_env, ARGV[0]
set :deploy_to, "/var/www/apps/#{application}/#{rails_env}"    ### activate for production deployment

set :scm, "git"
set :repository, "git@github.com:aghyad/website.git"
set :branch, "dev"
set :scm_verbose, true

namespace :deploy do
  desc 'Create default database'
  task :createdb, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "bundle exec rake")
    rails_env = ARGV[0]
    migrate_env = fetch(:migrate_env, "dev")
    migrate_target = fetch(:migrate_target, :latest)
    
    directory = case migrate_target.to_sym
    when :current then current_path
    when :latest  then latest_release
    else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
    end
    
    run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:create"
    run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:migrate"
    run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:seed"
  end
  
  ### activate ONLY for staging ##############################
  desc "Disallow search engine indexing"
  task :add_robots do
    if rails_env == "dev"
      run "touch #{deploy_to}/current/robots.txt; /bin/echo -en 'User-agent: *\\nDisallow: /' >> #{deploy_to}/current/robots.txt;"
    end
  end
  
  desc "Restart Application"
  task :restart do
    #run "chown -R apache:apache #{deploy_to}"
    #run "touch #{deploy_to}/current/tmp/restart.txt"
    run "/etc/init.d/nginx restart"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
