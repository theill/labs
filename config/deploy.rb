require 'gazebomachine/recipes'

set :stages, %w(staging production)
set :default_stage, 'staging'

# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

# The name of your application. Used for directory and file names associated with
# the application.
set :application, "labs.commanigy.com"

# Target directory for the application on the web and app servers.
set :deploy_to, "/var/www/apps/#{application}"

# Login user for ssh.
set :user, "deploy"
set :runner, "deploy"
set :admin_runner, "deploy"

set :scm, :git
set :repository, "git@github.com:theill/labs.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

# Automatically symlink these directories from curent/public to shared/public.
# set :app_symlinks, %w{photo document asset}

# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25

# =============================================================================
# CAPISTRANO OPTIONS
# =============================================================================
# default_run_options[:pty] = true
set :keep_releases, 3

require 'capistrano/ext/multistage'

namespace :deploy do
  desc "Restart a passenger hosted RoR app"
  task :restart, :roles => :app do
  run <<-EOF
cd #{deploy_to}/current/tmp && touch #{deploy_to}/current/tmp/restart.txt
EOF
  end
end