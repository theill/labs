set :rails_env, "production"

set :domain, "labs.commanigy.com.rails1.it-kartellet.dk"

role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain

set :application, "labs.commanigy.com"

set :use_sudo, false
set :deploy_to, "/home/peter/rails/#{application}"

set :user, "peter"
set :runner, "peter"
set :admin_runner, "peter"
