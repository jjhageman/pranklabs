# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :application, "pranklabs"
set :user, "prankla"
set :domain, "pranklabs.com"
set :mongrel_port, "4164"
set :server_hostname, "pranklabs.com"

role :app, server_hostname
role :web, server_hostname
role :db,  server_hostname, :primary => true

default_run_options[:pty] = true
set :repository,  "git@github.com:jjhageman/pranklabs.git"
set :scm, "git"
set :git_account, "jjhageman"
set :scm_passphrase, Proc.new { Capistrano::CLI.password_prompt('Git Password: ') }

ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :use_sudo, false
set :deploy_to, "/home/prankla/pranklabs"