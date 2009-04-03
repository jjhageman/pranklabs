load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'
namespace :deploy do

 task :start, :roles => :app do
  run "cd #{current_path} && mongrel_rails start -e production -p #{mongrel_port} -d"
 end

task :restart, :roles => :app do
  run "cd #{current_path} && mongrel_rails restart"
  run "pkill -9 searchd"
  run " cd #{current_path} && searchd --pidfile --config /home/prankla/pranklabs/current/config/production.sphinx.conf "
  run "cd #{current_path} && chmod 755 #{chmod755}"
 end
end