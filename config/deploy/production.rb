# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
# set :application, 'indoexchanger'
# # set :stage, :production
# set :stage, "production"
# set :rails_env, 'production'
# set :puma_env, "production"
# set :rack_env, "production"
# set :deploy_to, '/home/deploy/apps/indoexchanger'

set :branch, "master"
set :puma_env, "production"
set :rack_env, "production"
# set :stage, "production"
set :rails_env, "production"

after "deploy", "deploy:cleanup"
# delayed job
# set :delayed_job_args, "-n 4"

# http://stackoverflow.com/questions/21036175/how-to-deploy-a-specific-revision-with-capistrano-3
# set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || 'master'
server '139.59.116.39',
  user: fetch(:user),
  port: 89,
  roles: %w{web app db},
  primary: true,
  ssh_options: {
    user: fetch(:user), # overrides user setting above
    # keys: %w(/Users/cybergarage/.ssh/id_rsa),
    keys: %w(~/.ssh/id_rsa),
    # forward_agent: false,
    auth_methods: %w(publickey),
    # port: 4118,
    forward_agent: true
    # password: 'please use keys'
  }
# role :app, %w{deploy@10.66.218.177}
# role :web, %w{deploy@10.66.218.177}
# role :db,  %w{deploy@10.66.218.177}
# server '10.66.218.177', user: 'deploy', port: 89, roles: %w{web app}

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# set :application, 'indoexchanger'
# set :stage, :production
# set :rails_env, 'production'

# set :deploy_to, '/var/deploy/indoexchanger'

# # delayed job
# # set :delayed_job_args, "-n 4"

# # http://stackoverflow.com/questions/21036175/how-to-deploy-a-specific-revision-with-capistrano-3
# set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || 'master'

# role :app, %w{root@119.81.23.138}
# role :web, %w{root@119.81.23.138}
# role :db,  %w{root@119.81.23.138}
# server '119.81.23.138', user: 'root', roles: %w{web app}


#EDITED
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# role :app, %w{deploy@direct.41studio.com}
# role :web, %w{deploy@direct.41studio.com}

# set :branch, "master"
# set :puma_env, "production"
# set :rack_env, "production"
# set :stage, "production"
# set :rails_env, "production"

# after "deploy", "deploy:cleanup"
# # Extended Server Syntax
# # ======================
# # This can be used to drop a more detailed server
# # definition into the server list. The second argument
# # something that quacks like a hash can be used to set
# # extended properties on the server.
# # server 'direct.41studio.com', user: 'deploy', roles: %w{web app}



