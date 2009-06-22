load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'
after 'deploy:symlink', 'deploy:finishing_touches'
namespace :deploy do
 task :finishing_touches, :roles => :app do
  run "mv -f #{current_path}/config/environment.rb.online #{current_path}/config/environment.rb"
  run "ln -s /home/prankla/pranklabs/db/sphinx #{current_path}/db/sphinx" 
 end

 task :start, :roles => :app do
  run "cd #{current_path} && mongrel_rails start -e production -p #{mongrel_port} -d"
 end

 task :restart, :roles => :app do
  run "cd #{current_path} && mongrel_rails stop"
  run "cd #{current_path} && mongrel_rails start -e production -p #{mongrel_port} -d"
  run "pkill -9 searchd -u prankla"
  run "cd #{current_path} && rake thinking_sphinx:index"
  run "cd #{current_path} && rake thinking_sphinx:start"
  run "cd #{current_path} && chmod 755 #{chmod755}"
  run "mkdir #{current_path}/public/shared"
  run "ln -s /home/prankla/pranklabs/public/shared/images #{current_path}/public/shared/images"
  run "ln -s /home/prankla/prankblog #{current_path}/public/blog"
  cleanup
 end
end