require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina_sidekiq/tasks'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

# prod_domain, staging_domain
set :rails_env, 'production'
set :domain, '54.183.16.204'
set :branch, ENV['branch'] || 'production'
set :deploy_to, '/home/ubuntu/www/tan/'

set :repository, 'git@github.com:pathsource/tan.git'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp', 'config/secrets', 'config/application.yml' ]

# Optional settings:
set :user, 'ubuntu'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  # sidekiq needs a place to store its pid file and log file
  queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
  queue! %[mkdir -p "#{deploy_to}/shared/log/"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/reports"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/reports"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  puts "Deploy to #{rails_env} #{domain}"

  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'predb_process'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue! "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      queue! %[whenever --update-crontab -s 'environment=#{rails_env}' -f #{deploy_to}/#{shared_path}/config/schedule.rb]
      invoke :'sidekiq:restart'
    end
  end
end

desc "add tmply task for processing db for each deploy"
task :predb_process do
  # here should only add tmply task which only used for specific deployment
  # queue! "bundle exec rake clear_video_schools"
end

desc "Start or restart delayed_job"
task :up_delayed_job do
  echo "-----> Restart Delayed Job"
  queue! "bundle exec script/delayed_job -n 2 restart"
end

desc "Init redis data, should only did once"
task :init_redis_data do
  queue! "bundle exec rake create_redis_area_data"
end

desc "Run rake with mina, ex. mina task['test']"
task :run_rake, [:rake_task] => :environment do |t, args|
  queue! "cd #{deploy_to}/#{current_path}"
  queue! "ls"
  queue! "bundle exec rake #{args[:rake_task]}"
  # queue! "bundle exec rake testing"
end

desc "Show server logs"
task :logs do
  if rails_env == 'production'
    queue 'echo "Production logs:"'
  elsif rails_env == 'staging'
    queue 'echo "Staging logs:"'
  end
  queue! "tail -f -n 50 #{deploy_to}/#{current_path}/log/#{rails_env}.log"
end

desc "Sever restart"
task :restart do
  queue 'echo "Server restarting..."'
  queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
  queue 'echo "OK"'
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
