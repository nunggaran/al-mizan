# config valid only for current version of Capistrano
lock "3.9.1"

# Change these
# server '10.66.218.177', port: 89, roles: [:web, :app, :db], primary: true

set :application, "al-mizan"
# set :repo_url, "muhammadyana@bitbucket.org:thefutureindo/indoexchanger-v2.git"
set :repo_url, "git@github.com:muhammadyana/al-mizan.git"
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :linked_files, %w{.env}

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     invoke 'puma:restart'
  #   end
  # end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  # after  :finishing,    :restart
end

# set :application, "indoexchanger"
# set :repo_url, "muhammadyana@bitbucket.org:thefutureindo/indoexchanger-v2.git"
# # Configure puma
# set :pty,             true
# set :use_sudo,        true
# set :deploy_via,      :remote_cache
# set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
# set :puma_threads,    [2, 5]
# set :puma_workers,    1
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true  # Change to false when not using ActiveRecord
# # set :puma_threads, [1, 16]
# # set :puma_workers, 1
# # Default branch is :master
# # ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# set :user, "deploy"
# set :use_sudo, false
# set :deploy_via, :remote_cache
# set :keep_releases, 5
# # Default deploy_to directory is /var/www/my_app_name
# # set :deploy_to, "/var/www/my_app_name"
# set :linked_dirs, %w{log tmp/cache tmp/sockets tmp/puma/pid tmp/pids public/assets public/uploads}
# # Default value for :format is :airbrussh.
# # set :format, :airbrussh
# # set :ssh_options, { forward_agent: true, auth_methods: %w(publickey) }
# # You can configure the Airbrussh format using :format_options.
# # 
# SSHKit.config.command_map[:rake] = 'bundle exec rake'
# SSHKit.config.command_map[:runner] = 'bundle exec rails runner'

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end
# namespace :deploy do
#   desc "Copy linked files to server"
#   task :copy_config do
#     on release_roles :app do |role|
#       fetch(:linked_files).each do |linked_file|
#         user = role.user + "@" if role.user
#         hostname = role.hostname
#         linked_files(shared_path).each do |file|
#           run_locally do
#             execute :rsync, "config/#{file.to_s.gsub(/.*\/(.*)$/,"\\1")}", "#{user}#{hostname}:#{file.to_s.gsub(/(.*)\/[^\/]*$/, "\\1")}/"
#           end
#         end
#       end
#     end
#   end
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   # desc "Load database with seed data"
#   # task :seed do
#   #   run "cd #{deploy_to}/current; /usr/bin/env bundle exec rake db:seed RAILS_ENV=#{rails_env}"
#   # end

#   # after 'deploy:publishing', 'deploy:restart'
#   # namespace :deploy do
#   #   task :restart do
#   #     invoke 'delayed_job:restart'
#   #   end
#   # end

#   after :publishing, :restart
# end

# set :application, 'indoexchanger'
# set :repo_url, 'muhammadyana@bitbucket.org:thefutureindo/indoexchanger-v2.git'
# set :format, :pretty
# set :user, 'deploy'


# set :pty,             true
# set :use_sudo,        true
# set :deploy_via,      :remote_cache
# set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# set :puma_threads,    [2, 5]
# set :puma_workers,    0
# set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
# set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log,  "#{release_path}/log/puma.access.log"
# set :puma_preload_app, true
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# # set :linked_files,  %w{config/database.yml}
# set :linked_dirs,   %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :keep_releases, 5

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end

#   before :start, :make_dirs
# end

# namespace :install do
#   desc "install postgresql"
#   task :postgresql do
#     on roles(:app) do
#       sudo "apt-get update"
#       sudo "apt-get install postgresql libpgsql-ruby libpq-dev -y"
#     end
#   end
# end

# namespace :deploy do
#   desc "Copy linked files to server"
#   task :copy_config do
#     on release_roles :app do |role|
#       fetch(:linked_files).each do |linked_file|
#         user = role.user + "@" if role.user
#         hostname = role.hostname
#         linked_files(shared_path).each do |file|
#           run_locally do
#             execute :rsync, "config/#{file.to_s.gsub(/.*\/(.*)$/,"\\1")}", "#{user}#{hostname}:#{file.to_s.gsub(/(.*)\/[^\/]*$/, "\\1")}/"
#           end
#         end
#       end
#     end
#   end

#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles(:app) do
#       unless `git rev-parse HEAD` == `git rev-parse origin/master`
#         puts "WARNING: HEAD is not the same as origin/master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end

#   desc 'Initial Deploy'
#   task :initial do
#     on roles(:app) do
#       before 'deploy:restart', 'puma:start'
#       invoke 'deploy'
#     end
#   end

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       invoke 'puma:restart'
#     end
#   end


#   # task :resque_start do
#   #   on roles(:app) do
#   #     within "#{current_path}" do
#   #       with rails_env: "production" do
#   #         execute :rake, "resque:work RACK_ENV=production BACKGROUND=yes QUEUE=indoexchanger,sweep"
#   #       end
#   #     end
#   #   end
#   # end

#   before :starting,     :check_revision
#   after  :finishing,    :compile_assets
#   after  :finishing,    :cleanup
#   after  :finishing,    :restart
#   # after  :finishing,    :resque_start

#   task :seed do
#     on roles(:app) do
#       within "#{current_path}" do
#         with rails_env: "production" do
#           execute :rake, "db:seed"
#         end
#       end
#     end
#   end
# end


# # namespace :resque do
# #   task :start do
# #     on roles(:app) do
# #       within "#{current_path}" do
# #         with rails_env: "production" do
# #           execute :rake, "resque:work RACK_ENV=production BACKGROUND=yes QUEUE=indoexchanger,sweep"
# #         end
# #       end
# #     end
# #   end
# # end

# namespace :task do
#   desc 'Execute the specific rake task'
#   desc 'cap env "task:invoke[task_name]"'
#   task :invoke, :command do |task, args|
#     on roles(:app) do
#       within release_path do
#         with rails_env: fetch(:rails_env) do
#           # execute :rake, args[:command]
#           execute "rake #{args[:command]} #{ENV['OPTIONS']}"
#           #execute "cd #{fetch(:deploy_to)}/current && ( RAILS_ENV=#{fetch(:stage)} ~/.rvm/bin/rvm #{fetch(:rvm_ruby_version)} do bundle exec rake #{args[:command]} #{ENV['OPTIONS']} )"
#         end
#       end
#     end
#   end
# end


