# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'contest'
set :repo_url, 'git@github.com:12look/contest.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/contest'

set :deploy_user, 'deployer'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "reload the database with seed data"
  task :seed do
    puts "\n=== Seeding Database ===\n"
    on primary :db do
      within current_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

end
