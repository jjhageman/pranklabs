load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'
after 'deploy:symlink', 'deploy:finishing_touches'
namespace :deploy do
 task :finishing_touches, :roles => :app do
  run "mv -f #{current_path}/config/environment.rb.online #{current_path}/config/environment.rb"
 end

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